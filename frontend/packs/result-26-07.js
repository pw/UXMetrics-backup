const sortable = require('jquery-ui/ui/widgets/sortable');
import Hammer from 'hammerjs/hammer';
import Muuri from 'muuri/dist/muuri';
require("hammerjs");
require("muuri");

var $ = require("jquery");
var jQBridget = require('jquery-bridget');
var Packery = require('packery');
var Draggabilly = require('draggabilly');

function recalculateOrder(itemsContainer){
  $(this).find('.item').each(function(index, value) {
    $(this).find("input[name*='order']").val(index);
    $(this).find("p.order").html(index);
  });

  $(itemsContainer).each(function(){
    $(this).find('.item').each(function( index, value ) {
      $(this).find("input[name*='order']").val(index);
      $(this).find("p.order").html(index);
    });
  });
}


function debounce(func, wait, immediate){
	var timeout;
  return function() {
		var context = this, args = arguments;
		var later = function() {
			timeout = null;
			if (!immediate) func.apply(context, args);
		};
		var callNow = immediate && !timeout;
		clearTimeout(timeout);
		timeout = setTimeout(later, wait);
		if (callNow) func.apply(context, args);
	};
}

$(document).on('turbolinks:load', function(){
  var draggingItem = false;
  var onDropArea = false;
  var currentMousePos = { x: -1, y: -1 };
  var dragStart = 0;
  var buffer = 150;
  var initPos = 0;
  var tempElement;
  var inList = false;
  var fitComplete = true;


  $.bridget( 'packery', Packery, $ );

  var $grid = $('#test-columns').packery({
    itemSelector: '.muuri-new-column',
    // columnWidth helps with drop positioning
    columnWidth: 256,
    columnHeight: 152,
    gutter: 10
  });

  var pckry = Packery.data('#test-columns');


  pckry.on('fitComplete', function(event, item){
    // console.log("fitcomplete event");
    fitComplete = true;
  });



  function makeEachDraggable(i, itemElem) {
    var draggie = new Draggabilly(itemElem, {
      handle: '.muuri-handle'
    });
    $grid.packery('bindDraggabillyEvents', draggie);
  }



  $('#test-columns').find('.muuri-new-column').each(makeEachDraggable);

  var isActive = true;

  var dePosition = debounce(function(event) {

    // console.log(fitComplete);
    console.log("inList is: "+inList);

    if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252) && fitComplete == true && inList == false){
      onDropArea = true;
      fitComplete = false;
      // $('.empty-column').addClass('packery-drop-placeholder');
      $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y);
      $('.empty-column').addClass('droparea');
      $(".items").sortable("refresh");
    } else {
      onDropArea = false;

    }

    if (inList == true){
      $('.empty-column').removeClass('droparea');
    }

  }, 20);


  $(document).mousemove(function(event){
    currentMousePos.x = event.pageX;
    currentMousePos.y = event.pageY;
    dePosition(event);
  });



  $("#test-columns").on('click', function(event){

    if($(event.target).is('.delete-group') || ($(event.target).parents('.delete-group').length > 0 )){

      event.preventDefault();
      var element;
      element = $(event.target).parents("a.delete-group");

      $(element).closest(".muuri-new-column").find(".name-link").text("Add a name");
      $(element).closest(".muuri-new-column").find("input.name-input").val("");

      var nameInput = $(element).closest(".muuri-new-column").find(".name-input");
      var items = $(element).closest(".column-holder").find(".item");

      var itemsMoved = items.appendTo(".new-column");


      $grid.packery('remove', $(element).closest(".muuri-new-column")).packery('shiftLayout');

      // $(element).closest(".muuri-new-column").remove();

      // $(element).closest(".muuri-new-column").removeClass("used-column");
      // $(element).closest(".muuri-new-column").removeClass("used-column");
      // $(element).closest(".muuri-new-column").removeClass("bg-gray-300");
      // $(element).closest(".muuri-new-column").addClass("bg-transparent");
      //
      // $(element).closest(".muuri-new-column").find(".group-header").addClass("hidden");
      // $(element).closest(".muuri-new-column").find(".full-container").removeClass("full-container");

    } else if ($(event.target).is('a.name-link')){

      event.preventDefault();
      var element;
      element = $(event.target);

      $(element).hide();
      $(element).closest(".group-header").find(".delete-group").hide();
      $(element).closest(".group-header").find(".muuri-handle").hide();
      $(element).closest(".group-header").find(".name-input").show();
      $(element).closest(".group-header").find(".name-input").focus();

    } else {

    }

  });

  $(document).on('focus','input[type=text]',function(event){

  }).on('blur','input[type=text]', function(event){

    if ($(event.target).is('.name-input')){

      var element;
      element = $(event.target);

      if(!$(element).val() == ""){
        $(element).closest(".group-header").find(".name-link").text($(this).val());
        $(element).hide();
        $(element).closest(".group-header").find(".name-link").show();
        $(element).closest(".group-header").find(".delete-group").show();
        $(element).closest(".group-header").find(".muuri-handle").show();
      } else {
        $(element).closest(".group-header").find(".name-link").text("Add a name");
        $(element).hide();
        $(element).closest(".group-header").find(".name-link").show();
        $(element).closest(".group-header").find(".muuri-handle").show();
        $(element).closest(".group-header").find(".delete-group").show();
      }

    }

  });

  $(document).on('keydown','input[type=text]',function(event){

    var element;
    element = $(event.target);

    if (event.which == 13) {
      $(element).closest(".group-header").find(".name-link").text($(this).val());
      $(element).hide();
      $(element).closest(".group-header").find(".name-link").show();
      event.preventDefault();
    }
  });


  $(".submit-result").click(function(e){
    e.preventDefault();
    $("#new_result").submit();
  });


  var now = new Date().getTime();
  localStorage.setItem('init_time', now);

  var sortableOptions = {
    connectWith: ".items",
    zIndex: 10000,
    dropOnEmpty: true,
    update: function(event, ui) {

      $( "#new-column" ).sortable(sortableOptions);
      $( ".items" ).sortable(sortableOptionsOther);
      draggingItem = false;

      try {

        var itemOrder = $(this).sortable('toArray');
        var itemsContainer = $('.new-column');
        rebuildData();

      } catch(error) {
        console.log(error);
      }

    },
    out: function(event, ui){

    },
    start: function(event, ui){

      dragStart = currentMousePos.x;
      draggingItem = true;


    },
    stop: function(event, ui){

      $(".muuri-new-column").removeClass('droparea');
      console.log("STOPPP");

      draggingItem = false;
      // if (draggingItem == true){
      //
      //   $grid.packery('remove', $('.empty-column')[0]);
      //   $('.empty-column').remove();
      //   $( "#new-column" ).sortable(sortableOptions);
      //   $( ".items" ).sortable(sortableOptionsOther);
      //   draggingItem = false;
      //
      // }

      dragStart = 0;

    },
    change: function(event, ui){


    },
    receive: function(event, ui){

    },
    sort: function(event, ui){

    },
    appendTo: 'body',
    placeholder: "ui-sortable-placeholder"

  }


  if ($('#new-column').length>0){
    $( "#new-column" ).sortable(sortableOptions);
  }

  var sortableOptionsOther = {
    connectWith: ".new-column, .items",
    zIndex: 10000,
    dropOnEmpty: true,
    update: function(event, ui) {
      draggingItem = false;
      $(".muuri-new-column").removeClass("border-dashed border-gray-100 border-gray-400 border-gray-700 border-2");
      $( "#new-column" ).sortable(sortableOptions);
      $( ".items" ).sortable(sortableOptionsOther);
      var receivingList = $(event.target);
      receivingList.parents(".column-holder").find(".group-header").removeClass("hidden");

      try {
        var itemOrder = $(this).sortable('toArray');
        var itemsContainer = $('.items');
        recalculateOrder(itemsContainer);
        rebuildData();
      } catch(error){
        console.log(error);
      }
    },
    out: function(event, ui){
      var receivingList = $(event.target);
      console.log("out - setting inlist to false");

      inList = false;
    },
    over: function(){
      console.log("over - setting inlist to true");
      inList = true;
    },
    start: function(event, ui){
      $(".muuri-new-column").css('z-index', 1000);
      $(event.currentTarget).css('z-index', 9000);
      $(event.currentTarget).parents(".muuri-new-column").css('z-index', 9000);
      draggingItem = true;
    },
    stop: function(event, ui){
        draggingItem = false;


        // $grid.packery('layout');
    },
    change: function(event, ui){
      var receivingList = $(event.target);
      $(".muuri-new-column").removeClass("border-dashed border-gray-700 border-2");

      if (!receivingList.parents(".muuri-new-column").hasClass("used-column")){
        receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
      }
    },
    sort: function(event, ui){

    },
    appendTo: 'body',
    placeholder: "ui-sortable-placeholder"

  }

  if ($('.items').length>0){
    $( ".items" ).sortable(sortableOptionsOther);
  }

  function rebuildData(){
    console.log("REBUILD DATA");
    var data = [];
    fitComplete = true;

    $(".items").each(function(index, value){
      data[index] = $(this).sortable('toArray');

      if ($(this).children().length > 0 && !$(this).hasClass("full-container")){
        $(this).addClass("full-container");
        $(this).removeClass("h-32");
        $(this).parents(".muuri-new-column").addClass("bg-gray-300 used-column");
        $(this).parents(".muuri-new-column").removeClass("empty-column");
        // $grid.packery('reloadItems');
        // $grid.packery('layout');
      }

    });

    if($('.empty-column').length < 1 ){
      tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';

      var $tempElement = $(tempElement);
      $('#test-columns').append($tempElement).packery('appended',$tempElement);
      // $grid.packery('reloadItems');
      $tempElement.each(makeEachDraggable);
      $( "#new-column" ).sortable(sortableOptions);
      $( ".items" ).sortable(sortableOptionsOther);
    }
  }

  $("#new_result").submit(function(e){
      e.preventDefault();
      var self = this;

      var data = {
        name: "",
        time: "",
        groups: []
      };
      var items =[];
      var groupTitles = [];
      var columnCards = [];
      var submit_time = new Date().getTime();
      var time_spent = submit_time - Number(localStorage.getItem('init_time'));
      data.name = "testJSONname";
      data.time = time_spent;

      $(".items").each(function(index, value){
        if($(this).parents('.column-holder').find('.container-name').val()){
          groupTitles[index] = $(this).parents('.column-holder').find('.container-name').val();
        } else {
          groupTitles[index] = "Unnamed";
        }
        columnCards[index] = $(this).sortable('toArray');
        var group = {
          "title": groupTitles[index],
          "card": columnCards[index]
        }
        data.groups.push(group);

      });

      $('#result_data').val(JSON.stringify(data));
      self.submit();

  });



});
