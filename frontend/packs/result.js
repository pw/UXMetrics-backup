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

  $(".close-validation").click(function(e){
    e.preventDefault();
    $(".validation").hide();
  });



  var itemDragged;
  var draggingItem = false;
  var onDropArea = false;
  var currentMousePos = { x: -1, y: -1 };
  var dragStart = 0;
  var buffer = 150;
  var initPos = 0;
  var tempElement;
  var inList = false;
  var inGroup = false;
  var inDropArea = false;
  var fitComplete = true;
  var sourceShelf = true;


  $.bridget( 'packery', Packery, $ );

  var $grid = $('#test-columns').packery({
    itemSelector: '.muuri-new-column',
    // columnWidth helps with drop positioning
    columnWidth: 256,
    columnHeight: 152,
    gutter: 10,
    transitionDuration: '0s'
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


  // if($('.empty-column').length < 1 ){
  //     console.log("adding temp elem");
  //   tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';
  //
  //   var $tempElement = $(tempElement);
  //   $('#test-columns').append($tempElement).packery('appended',$tempElement);
  //   // $grid.packery('reloadItems');
  //   $tempElement.each(makeEachDraggable);
  //   $( "#new-column" ).sortable(sortableOptions);
  //   $( ".items" ).sortable(sortableOptionsOther);
  // }

 //
 //  $(".item").mousedown(function() {
 //     console.log("this");
 //     console.log("mousedown");
 //     if($('.empty-column').length < 1 ){
 //         console.log("adding temp elem");
 //       tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column droparea">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';
 //
 //       var $tempElement = $(tempElement);
 //       $('#test-columns').append($tempElement).packery('appended',$tempElement);
 //       // $grid.packery('reloadItems');
 //       // $tempElement.each(makeEachDraggable);
 //       $( "#new-column" ).sortable(sortableOptions);
 //       $( ".items" ).sortable(sortableOptionsOther);
 //     }
 // });






  var isActive = true;

  var dePosition = debounce(function(event) {


    // console.log(fitComplete);
    // console.log("inList is: "+inList);

    if (draggingItem == true && fitComplete == true && inGroup == true && inDropArea == false && inList == false){
      // console.log("hiding because it's in a group");
      console.log("Group true, hiding");
      $('.empty-column').hide();
      $grid.packery('shiftLayout');
      // $grid.packery( 'fit', $('.empty-column')[0], 9999, 9999);
    } else if (draggingItem == true && fitComplete == true && inGroup == false && inDropArea == false && inList == false){
      console.log("All false, showing");
      $('.empty-column').show();
      $grid.packery('shiftLayout');
      // console.log("showing because it's not in any container");
    } else if (draggingItem == true && fitComplete == true && inGroup == false && inDropArea == true && inList == false){
      console.log("droparea true, not doing anything");
      // $('.empty-column').hide();
      // console.log("hiding because it's in empty drop area");
    } else if (draggingItem == true && fitComplete == true && inGroup == false && inDropArea == false && inList == true){
      console.log("list is true, hiding");
      $('.empty-column').hide();
      $grid.packery('shiftLayout');
    }

    if (draggingItem == true){
      // START HERE TOMORROW



      // $('.empty-column').show();
      // if($('.empty-column').length < 1 ){
      //     console.log("adding empty temp element because draggingItem is TRUE");
      //   tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column droparea">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';
      //
      //   var $tempElement = $(tempElement);
      //   $('#test-columns').append($tempElement).packery('appended',$tempElement);
      //   // $grid.packery('reloadItems');
      //   $tempElement.each(makeEachDraggable);
      //   $( "#new-column" ).sortable(sortableOptions);
      //   console.log($( "#new-column" ).sortable("refresh"));
      //   $( ".items" ).sortable(sortableOptionsOther);
      //   console.log($( ".items" ).sortable("refresh"));
      // }

    }


    console.log(draggingItem+" "+fitComplete+" "+inGroup+" "+inList+" "+inDropArea);

    // console.log("DraggingItem: ");
    // console.log(draggingItem);
    // console.log("fitComplete: ");
    // console.log(fitComplete);
    // console.log("inGroup: ");
    // console.log(inGroup);
    // console.log("inlist: ");
    // console.log(inList);
    // console.log("inDropArea: ");
    // console.log(inDropArea);






    if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252) && fitComplete == true && inGroup == false && inList == false && inDropArea == false && testType != "closed"){
      // console.log("could dropm, inList IS: "+inList);

      // if($('.empty-column').length < 1 ){
      //   console.log("adding temp elem");
      //   tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column droparea">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';
      //
      //   var $tempElement = $(tempElement);
      //   $('#test-columns').append($tempElement).packery('appended',$tempElement);
      //   // $grid.packery('reloadItems');
      //   $tempElement.each(makeEachDraggable);
      //   $( "#new-column" ).sortable(sortableOptions);
      //   $( ".items" ).sortable(sortableOptionsOther);
      // }




      onDropArea = true;
      // fitComplete = false;
      // $('.empty-column').addClass('packery-drop-placeholder');
      if (sourceShelf == true){
        $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y-100);
      } else {
        console.log("&&&&&&&& ELSE &&&&&&&&");
        $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - 240, currentMousePos.y - 100);
        console.log(currentMousePos.x);
      }
      // $('.empty-column').addClass('droparea');
      $(".items").sortable("refresh");
    } else {
      onDropArea = false;

    }

    if (inList == true){
      //$('.empty-column').removeClass('droparea');
    }

  }, 2);


  $(document).mousemove(function(event){
    currentMousePos.x = event.pageX;
    currentMousePos.y = event.pageY;

    // need to set inlist false if mouse moves outside group
    if (draggingItem == true){
      // console.log("parents:");
      // console.log(itemDragged.parents(".muuri-new-column"));

      // changed this from .muuri-new-column to .used-column
      // console.log("dragging child of used-column? "+itemDragged.parents(".used-column").length);
      // console.log(itemDragged.parents(".used-column").length);
      // console.log("dragging child of empty-column? "+itemDragged.parents(".empty-column").length);
      // console.log(itemDragged.parents(".empty-column").length);


      // console.log("how come not list?");
      // console.log(itemDragged.parents(".new-column").length);

      if (itemDragged.parents(".used-column").length>0){

        // !!! AND BELOW!
        var containerLeft = itemDragged.parents(".used-column").offset().left;
        var containerTop = itemDragged.parents(".used-column").offset().top;

        // console.log("left:");
        // console.log(itemDragged.parents(".muuri-new-column").offset().left);
        // console.log(currentMousePos.x);
        // console.log("top:");
        // console.log(itemDragged.parents(".muuri-new-column").offset().top);
        // console.log(currentMousePos.y);
        //
        // console.log("width:");
        // console.log(itemDragged.parents(".muuri-new-column").width());
        //
        // console.log("height:");
        // console.log(itemDragged.parents(".muuri-new-column").height());

        // !!!AND BELOW!!

        var containerRight = containerLeft + itemDragged.parents(".used-column").width();
        var containerBottom = containerTop + itemDragged.parents(".used-column").height()+5;

        if (currentMousePos.x < containerLeft || currentMousePos.x > containerRight || currentMousePos.y < containerTop || currentMousePos.y > containerBottom) {

          console.log("outside");
          inGroup = false;


        }

        if (currentMousePos.x > containerLeft && currentMousePos.x < containerRight && currentMousePos.y > containerTop && currentMousePos.y < containerBottom) {

          console.log("inside");
          inGroup = true;
          inDropArea = false;


        }






      }

      if (itemDragged.parents(".empty-column").length>0){


        var containerLeft = itemDragged.parents(".empty-column").offset().left;
        var containerTop = itemDragged.parents(".empty-column").offset().top;


        var containerRight = containerLeft + itemDragged.parents(".empty-column").width();
        var containerBottom = containerTop + itemDragged.parents(".empty-column").height()+5;



        if (currentMousePos.x < containerLeft || currentMousePos.x > containerRight || currentMousePos.y < containerTop || currentMousePos.y > containerBottom) {

          console.log("outside of empty");
          inDropArea = false;
          inGroup = false;

          // console.log("Mouse: "+currentMousePos.x+", "+currentMousePos.y);
          // console.log("Container L/R/T/B: "+containerLeft+"/"+containerRight+"/"+containerTop+"/"+containerBottom);
          // console.log(itemDragged.parent().parent().parent());

        }

        if (currentMousePos.x > containerLeft && currentMousePos.x < containerRight && currentMousePos.y > containerTop && currentMousePos.y < containerBottom) {

          console.log("inside of empty");
          inDropArea = true;

          // console.log("Mouse: "+currentMousePos.x+", "+currentMousePos.y);
          // console.log("Container L/R/T/B: "+containerLeft+"/"+containerRight+"/"+containerTop+"/"+containerBottom);
          // console.log(itemDragged.parent().parent().parent());

        }

      }

      if (itemDragged.parents(".new-column").length>0){
        console.log("parent is initial list");
        var listRight = itemDragged.parents(".new-column").width();

        if (currentMousePos.x > listRight){
          inList = false;
        } else {
          inList = true;
        }

      }



    }

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

      rebuildData();

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
        console.log("fixednamething");
        console.log($(element).val());
        console.log($("p.fixedname").textContent);

        var duplicate = false;

        // $("p.fixedname").each(function() {
        //   console.log($(this)[0].textContent);
        //   if(($(element).val() == $(this)[0].textContent)){
        //
        //     duplicate = true;
        //     return false;
        //   }
        //
        // });

        var dup_count = 0;
        $(".name-input").each(function() {
          // console.log($(this)[0].textContent);
          if($(element).val() == $(this).val()){
            console.log("found dup");
            dup_count++;
            if (dup_count > 1){
              duplicate = true;
              return false;
            }

          }

        });



        // console.log(ttt);

        if (duplicate == false){
          $(element).closest(".group-header").find(".name-link").text($(this).val());
          $(element).hide();
          $(element).closest(".group-header").find(".name-link").show();
          $(element).closest(".group-header").find(".delete-group").show();
          $(element).closest(".group-header").find(".muuri-handle").show();
        } else {

          $(".validation p").text("This group name is already in use, please use different name.");
          $(".validation").css('display', 'flex');
          $(element).focus();

        }

        // console.log($.inArray($(element).val(), $("p.fixedname").textContent));






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




      inList = true;
      dragStart = currentMousePos.x;
      draggingItem = true;
      itemDragged = ui.item;
      // console.log(itemDragged.parents(".new-column"));
      console.log("------------START ONEEEEEEEE------------");
      sourceShelf = true;

      $('.helper').hide();




    },
    stop: function(event, ui){

      // $(".muuri-new-column").removeClass('droparea');
      console.log("stop event triggering!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      $('.empty-column').hide();
      // $grid.packery( 'remove', $('.empty-column')[0]).packery('shiftLayout');
      //$('.empty-column').hide();
      // $grid.packery( 'fit', $('.empty-column')[0], 9999, 9999);

      inList = false;
      inGroup = false;
      inDropArea = false;
      console.log("STOPPP, setting inlist false");

      $grid.packery('shiftLayout');
      // draggingItem = false;
      if (draggingItem == true){
        //
        // $grid.packery('remove', $('.empty-column')[0]);
        // $('.empty-column').remove();
        $( "#new-column" ).sortable(sortableOptions);
        $( ".items" ).sortable(sortableOptionsOther);
        draggingItem = false;

      }
      rebuildData();

      dragStart = 0;

      if ($(".muuri-new-column").hasClass("used-column") == 0){
        // not working for some reason
        $('.helper').show();
      } else {
        $('.helper').hide();
      }


    },
    change: function(event, ui){
      console.log("change groups");
      $grid.packery('shiftLayout');
      // $('.empty-column').hide();
      // inGroup = true;

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
      // console.log("out - setting inlist to false");

      // need to set this differently
      // console.log("setting inlist to false");
      // inList = false;
    },
    over: function(event, ui){
      console.log("over");

      itemDragged = ui.placeholder;
      console.log(itemDragged.parents(".empty-column").length);
      inDropArea = true;

      if (itemDragged.parents('.used-column').length > 0){
        console.log("over - setting inGroup to true");
        inGroup = true;
        itemDragged = ui.placeholder;
        console.log(itemDragged.parents(".empty-column").length);
      }
      // console.log(itemDragged.parents('.used-column'));
      // itemDragged.addClass("bg-orange-600");
      // inList = true;
    },
    start: function(event, ui){

      // $('.empty-column').show();

      // $('.empty-column').show();

      console.log(ui.item.offset().left);
      dragStart = currentMousePos.x - ui.item.offset().left;
      console.log("------------START TWOOOOOOOO------------");
      sourceShelf = false;

      $(".muuri-new-column").css('z-index', 1000);
      $(event.currentTarget).css('z-index', 9000);
      $(event.currentTarget).parents(".muuri-new-column").css('z-index', 9000);
      draggingItem = true;
      inGroup = true;
      // need to pass the item being dragged in a variable
      // so I can check if it cursor goes out of bounds of it's container

      itemDragged = ui.item;
      console.log(itemDragged);

    },
    stop: function(event, ui){
      console.log("Stop event 2 triggering !!!!!!!!!!!");
      // $grid.packery( 'remove', $('.empty-column')[0]).packery('shiftLayout');
      // $grid.packery( 'fit', $('.empty-column')[0], 9999, 9999);
      $('.empty-column').hide();
      console.log("stopped, setting inlist to false");
      // $(".muuri-new-column").removeClass('droparea');
      draggingItem = false;
      inList = false;
      inGroup = false;
      inDropArea = false;


        // $grid.packery('layout');
    },
    receive: function(event, ui){
      console.log("receive !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    },
    change: function(event, ui){
      console.log("change list");
      // $('.empty-column').hide();
      $grid.packery('shiftLayout');

      var receivingList = $(event.target);
      // console.log(event);
      // console.log(receivingList);
      // console.log(ui.helper.parents(".empty-column"));
      // console.log(ui.item.parents(".empty-column"));
      // console.log(event);
      // console.log(receivingList);
      itemDragged = ui.item;
      // console.log(itemDragged);
      // console.log("is it empty? :"+receivingList.parents(".emtpy-column").length);

      // $(".muuri-new-column").removeClass("border-dashed border-gray-700 border-2");


      // START HERE - just replaced receivingList with itemDragged
      // CONT - problem is that empty-column is shown when inside group.
        if (itemDragged.parents(".muuri-new-column").hasClass("empty-column")){
          itemDragged.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
          console.log("DROPAREA IS FALSE, SETTING TO TRUE");
          inDropArea = true;
          inList = false;
          inGroup = false;
        }

        if (itemDragged.parents(".muuri-new-column").hasClass("used-column")){
          // receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
          inDropArea = false;
          inList = false;
          inGroup = true;
        }

        if (itemDragged.parents(".muuri-new-column").hasClass("new-column")){
          // receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
          inDropArea = false;
          inList = true;
          inGroup = false;
        }

      // if (!receivingList.parents(".muuri-new-column").hasClass("used-column")){
      //   // console.log("NOT setting inlist");
      //
      //
      //   inDropArea = true;
      //   inList = false;
      //   inGroup = false;
      //   // inList = true;
      //   receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
      // } else if (receivingList.parents(".muuri-new-column").hasClass("used-column")){
      //   console.log("Setting inGroup to true");
      //   inDropArea = false;
      //   inList = false;
      //   inGroup = true;
      //
      //   // $grid.packery( 'remove', $('.empty-column')[0]).packery('shiftLayout');
      //
      //
      // }
      // inList = true;



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

    // $(".muuri-new-column").removeClass('droparea');

    $(".used-column").removeClass("droparea");

    if($('.empty-column').length < 1 && testType != "closed"){
        console.log("adding temp elem");
      tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded empty-column droparea">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';

      var $tempElement = $(tempElement);
      $('#test-columns').append($tempElement).packery('appended',$tempElement);
      // $grid.packery('reloadItems');
      $tempElement.each(makeEachDraggable);
      $( "#new-column" ).sortable(sortableOptions);
      $( ".items" ).sortable(sortableOptionsOther);
    }




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

      if ($(this).children().length == 0 && !$(this).parents(".muuri-new-column").hasClass('empty-column') && !$(this).parents(".muuri-new-column").hasClass('fixedgroups')){
        console.log($(this).parents('.muuri-new-column'));
        console.log("this happens?");
        $(this).parents(".muuri-new-column").remove();
        $( "#new-column" ).sortable(sortableOptions);
        $( ".items" ).sortable(sortableOptionsOther);
      }

    });





    if ($(".muuri-new-column").hasClass("used-column") == 0){
      // not working for some reason
      $('.helper').show();
    } else {
      $('.helper').hide();
    }




  }

  $("#new_result").submit(function(e){
      e.preventDefault();
      var self = this;
      console.log("submit");
      var validation = false;
      var err = "";
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




      $(".used-column .items").each(function(index, value){

        console.log("count: "+index);
        // START HERE
        //fkin exclude empty-columns from validation!!

        if($(this).parents('.used-column').find('.container-name').val()){
          groupTitles[index] = $(this).parents('.used-column').find('.container-name').val();
        } else {
          console.log("found unnamed group");
          validation = true;
          err = "unnamed";
          groupTitles[index] = "Unnamed";
        }
        columnCards[index] = $(this).sortable('toArray');
        var group = {
          "title": groupTitles[index],
          "card": columnCards[index]
        }
        if (group.card != ''){
          data.groups.push(group);
        }

      });
      // alert($("#new-column .item").length);

      var m = (mandatory =="true");

      // alert("mandatory: "+typeof(mandatory));
      // alert("valition: "+validation);
      // alert("length: "+ ($("#new-column .item").length >= 1));

      if (($("#new-column .item").length >= 1) && m){
        // alert("this shouldn't trigger now");
        // console.log($("#new-column .item").length);
        // console.log("still left to sort");
        validation = true;
        err = "notsorted";
      }
      // alert("validtion: "+validation);

      if (validation == true){
        console.log("validation errors found");

        if (err == "notsorted"){
          $(".validation p").text("Please sort all the cards from the column on the left!");
        } else if (err == "unnamed"){
          $(".validation p").text("Please name your groups by clicking 'Add a name'. ");
        }


        $(".validation").css('display', 'flex');
        return false; // don't submit
      }

      $('#result_data').val(JSON.stringify(data));

      // alert(location.search);
      if (location.search.indexOf("preview")>=0){
        // preview, don't submit just go to thank you
        console.log(window.location.pathname);
        window.location.replace(window.location.pathname+"/thanks?preview=true");
      } else {
        // not preview, submit data
        self.submit();
      }




  });



});
