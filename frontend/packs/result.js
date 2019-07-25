const sortable = require('jquery-ui/ui/widgets/sortable');
// const packery = require("packery/js/packery");
// const packery = require("packery/dist/packery.pkgd");

// var Packery = require('packery');

import Hammer from 'hammerjs/hammer';
import Muuri from 'muuri/dist/muuri';




require("hammerjs");
require("muuri");



  var $ = require("jquery");
  var jQBridget = require('jquery-bridget');
  var Packery = require('packery');
  var Draggabilly = require('draggabilly');

  // var $container = $('#test-columns');



function recalculateOrder(itemsContainer){

  console.log("Recalculate order of cards across items");

  // Working! recalculating order over multiple columns

  // console.log("items:");
  //console.log(itemsContainer.sortable('toArray'));
  // console.log("itemOrder:");

  // console.log("recalc");
  $(this).find('.item').each(function( index, value ) {
    // console.log("cycling through items: "+index);
    $(this).find("input[name*='order']").val(index);
    $(this).find("p.order").html(index);
  });

  $(itemsContainer).each(function(){
    // console.log("Container found");
    $(this).find('.item').each(function( index, value ) {
      $(this).find("input[name*='order']").val(index);
      $(this).find("p.order").html(index);
    });

  });


}


function debounce(func, wait, immediate) {
	var timeout;
  // console.log("debounce");
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
};


function drawCoordinates(x,y){
    var pointSize = 3; // Change according to the size of the point.
    var ctx = document.getElementById("canvas").getContext("2d");

    console.log("x: ");
    console.log(x);
    console.log("y: ");
    console.log(y);

    ctx.fillStyle = "#ff2626"; // Red color

    ctx.beginPath(); //Start path
    ctx.arc(x, y, pointSize, 0, Math.PI * 2, true); // Draw a point using the arc function of the canvas with a point structure.
    ctx.fill(); // Close the path and fill.
}








$(document).on('turbolinks:load', function(){

  $('#new-column').on('mousedown',function(event){

    console.log($(event.target));

    if($(event.target).is('.item') || ($(event.target).parents('.item').length > 0 )){
      console.log("ITEM");
      // $( ".empty-column" ).trigger(event);
    }


  //     console.log(event);
  //     var e = $.Event( "mousedown" );
  //     console.log(e);
  //     $( ".empty-column" ).trigger(event);
  // });


  // $("div").delegate(".item", "mousedown", function(event) {
  // $( ".item" ).mousedown(function(event) {
    console.log("mousedown");
    console.log(event);

    // var md = new Event('mousedown');
    // // var e = event;
    // var elem = document.querySelectorAll(".empty-column");
    // elem.dispatchEvent(md);

    // $( ".empty-column" ).mousedown();
  });

  console.log("DOCUMENT: LOADED");

  var draggingItem = false;
  var onDropArea = false;
  var currentMousePos = { x: -1, y: -1 };
  var dragStart = 0;
  var buffer = 150;
  var initPos = 0;
  var tempElement;


  var dePosition = debounce(function(event) {

    // console.log(event.pageX);

    console.log("--- mouse move --- debounced");

    // console.log((currentMousePos.x - dragStart + 120 > 252));

    // console.log(Math.abs(initPos - currentMousePos.x - dragStart + 120));
    // if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252) && Math.abs(initPos - currentMousePos.x - dragStart + 120) > buffer){
    if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252)){

      // initPos = currentMousePos.x - dragStart + 120;
      // console.log(initPos);


      onDropArea = true;


      // console.log($('.muuri-new-column')[0]);


      console.log("Dragging is true and outside of the left column, calling packery fit and sortables");



      //
      //

      //
      //
      // var $items = $('.muuri-new-column').draggable();
      //
      // $grid.packery( 'bindUIDraggableEvents', $items );

      // $('.empty-column').removeClass('hidden');
      $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y );
      // drawCoordinates(50,50);
      // drawCoordinates(10,10);
      console.log("DRAGSTART:");
      console.log(dragStart);

      // console.log("Adding dot to:");
      // console.log(currentMousePos.x - 272 - dragStart);



      // drawCoordinates(currentMousePos.x - 272 - dragStart,currentMousePos.y);
      // var test = $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - 272 - dragStart, currentMousePos.y );

      // $( "#new-column" ).sortable(sortableOptions);
      // $( ".items" ).sortable(sortableOptionsOther);

      // $("#new-column").sortable(sortableOptions);
      // $(".items").sortable(sortableOptionsOther);
      // $("#new-column").sortable("refresh");
      // $("#new-column").sortable("refreshPositions");
      $(".items").sortable("refresh");
      // $(".items").sortable("refreshPositions");





    } else {
      onDropArea = false;
    }

  }, 200);


  function nonDePosition(event){
    console.log(event.pageX);
    currentMousePos.x = event.pageX;
    currentMousePos.y = event.pageY;

    if(draggingItem == true){

      // console.log(dragStart);
    }
    // console.log((currentMousePos.x - dragStart + 120 > 252));

    // console.log(Math.abs(initPos - currentMousePos.x - dragStart + 120));
    if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252)){

      initPos = currentMousePos.x - dragStart + 120;


      onDropArea = true;
      var element = '<div class="muuri-new-column mt-0 w-64 absolute rounded bg-gray-200">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';

      // console.log($('.muuri-new-column')[0]);


      console.log("calling fit");
      $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y );



    } else {
      onDropArea = false;
    }

  }

    $(document).mousemove(function(event){
      // console.log("CONSTANTLY");
      currentMousePos.x = event.pageX;
      currentMousePos.y = event.pageY;
      dePosition(event);




    });



  $("#test-columns").on('click', function(event){
    console.log(event.target);
    // console.log($(event.target).parents("a.delete-group"));

    if($(event.target).is('.delete-group') || ($(event.target).parents('.delete-group').length > 0 )){
      console.log("delete");
      event.preventDefault();

      var element;

      element = $(event.target).parents("a.delete-group");

      console.log(element);

      $(element).closest(".muuri-new-column").find(".name-link").text("Add a name");
        $(element).closest(".muuri-new-column").find("input.name-input").val("");

        var nameInput = $(element).closest(".muuri-new-column").find(".name-input");
        var items = $(element).closest(".column-holder").find(".item");
        // console.log("ITEMS:");
        // console.log(items);
        // items.remove();

        var itemsMoved = items.appendTo(".new-column");
        // console.log(itemsMoved);
        $(element).closest(".muuri-new-column").removeClass("used-column");
        $(element).closest(".muuri-new-column").removeClass("used-column");
        $(element).closest(".muuri-new-column").removeClass("bg-gray-300");
        $(element).closest(".muuri-new-column").addClass("bg-transparent");

        console.log($(element).closest(".muuri-new-column").find(".name-input"));
        console.log("setting value");

        $(element).closest(".muuri-new-column").find(".group-header").addClass("hidden");
        $(element).closest(".muuri-new-column").find(".full-container").removeClass("full-container");


    } else if ($(event.target).is('a.name-link')){
      console.log("name link click");
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

    console.log("focus");




  }).on('blur','input[type=text]', function(event){

    console.log("blur event");

    if ($(event.target).is('.name-input')) {
      console.log("blur name input");

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

  // $(".name-input").on('keydown', function(e) {
  //   if (e.which == 13) {
  //     $(this).closest(".group-header").find(".name-link").text($(this).val());
  //     $(this).hide();
  //     $(this).closest(".group-header").find(".name-link").show();
  //     e.preventDefault();
  //   }
  // });


  $(".submit-result").click(function(e){
    e.preventDefault();
    $("#new_result").submit();
  });


  var now = new Date().getTime();
  //var formatted = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds();
  localStorage.setItem('init_time', now);


  var sortableOptions = {
            connectWith: ".items",
            zIndex: 10000,
            dropOnEmpty: true,
            update: function(event, ui) {


              $( "#new-column" ).sortable(sortableOptions);
              $( ".items" ).sortable(sortableOptionsOther);

              console.log("SORTABLE: UPDATE -> rebuildData");

              draggingItem = false;
              console.log(draggingItem);


                try {
                  console.log($(this));
                  var itemOrder = $(this).sortable('toArray');


                var itemsContainer = $('.new-column');
                // recalculateOrder(itemsContainer);
                rebuildData();
                }

                catch(error){
                  console.log(error);
                }

             },

              out: function(event, ui){
                console.log("SORTABLE: OUT");



                // this if statement should never trigger? we def have empty-column at this point
                // if(draggingItem == true && $('.empty-column').length < 1 ){
                //
                //       console.log("Currently dragging, there is no empty-column, so adding a new one and calling sortables");
                //       $grid.packery('appended', tempElement);
                //       // $grid.packery('layout');
                //
                //       $( "#new-column" ).sortable(sortableOptions);
                //       $( ".items" ).sortable(sortableOptionsOther);
                //
                //       // tempElement = $grid.append(element);
                //
                // }


              },
              start: function(event, ui){
                // console.log("start event");
                //getCursorPosition();
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });

                console.log("SORTABLE: START");
                console.log("draggingItem set to true");
                dragStart = currentMousePos.x;
                draggingItem = true;
                console.log(draggingItem);




                // $grid.packery();
              },
              stop: function(event, ui){
                // console.log("stop event");
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });

                console.log("SORTABLE: STOP");

                // console.log("removing empty temp");
                console.log("draggingItem is");
                console.log(draggingItem);
                if (draggingItem == true){
                  console.log("Revmoing empty-column from packery and from DOM and running sortables, setting dragging to false");
                  $grid.packery('remove', $('.empty-column')[0]);
                  $('.empty-column').remove();

                  // $grid.packery('layout');

                  $( "#new-column" ).sortable(sortableOptions);
                  $( ".items" ).sortable(sortableOptionsOther);


                  draggingItem = false;
                  console.log(draggingItem);
                }
                dragStart = 0;



                // $grid.packery();

                //getCursorPosition();
              },
              change: function(event, ui){
                // console.log("change");
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });



                // $grid.packery();
              },
              receive: function(event, ui)
              {
                console.log("SORTABLE OTHER: RECEIVED");
              },
              appendTo: 'body',
              placeholder: "ui-sortable-placeholder"

          }


  if ($('#new-column').length>0){
    // console.log("new column present");
    console.log("SORTABLE: INIT");
    $( "#new-column" ).sortable(sortableOptions);
    // console.log($( ".new-column" ));
    // console.log($( ".new-column" ).sortable('toArray'));

    }

    //connect

    var sortableOptionsOther = {
              connectWith: ".new-column, .items",
              zIndex: 10000,
              dropOnEmpty: true,
              update: function(event, ui) {
                console.log("SORTABLE OTHER: UPDATE");

                draggingItem = false;
                console.log(draggingItem);

                $(".muuri-new-column").removeClass("border-dashed border-gray-100 border-2");

                $( "#new-column" ).sortable(sortableOptions);
                $( ".items" ).sortable(sortableOptionsOther);

                var receivingList = $(event.target);
                // console.log("receivinglist: ");
                // console.log(receivingList);
                receivingList.parents(".column-holder").find(".group-header").removeClass("hidden");
                try {
                  var itemOrder = $(this).sortable('toArray');

                  var itemsContainer = $('.items');
                  recalculateOrder(itemsContainer);
                  rebuildData();
                }
                catch(error){
                  console.log(error);
                }
               },

                out: function(event, ui){
                  console.log("SORTABLE OTHER: OUT");
                  var receivingList = $(event.target);
                  // draggingItem = true;
                  console.log(draggingItem);
                  // grid.refreshItems().layout(function (items) {
                  //   // console.log('layout updated!');
                  // });
                  // $grid.packery();
                  // receivingList.parents(".muuri-new-column").removeClass("border-dashed border-gray-100 border-2");

                },
                start: function(event, ui){
                  // console.log("start event");
                  console.log("SORTABLE OTHER: START");
                  $(".muuri-new-column").css('z-index', 1000);
                  $(event.currentTarget).css('z-index', 9000);
                  $(event.currentTarget).parents(".muuri-new-column").css('z-index', 9000);
                  draggingItem = true;
                  console.log(draggingItem);
                  // grid.refreshItems().layout(function (items) {
                  //
                  // });
                  // $grid.packery();
                  //getCursorPosition();
                },
                stop: function(event, ui){
                  console.log("SORTABLE OTHER: STOP");
                  draggingItem = false;
                  console.log(draggingItem);
                  // grid.refreshItems().layout(function (items) {
                  //   // console.log('layout updated!');
                  // });
                  // $grid.packery();
                  //getCursorPosition();
                },
                change: function(event, ui){
                  console.log("SORTABLE OTHER: CHANGE");
                  var receivingList = $(event.target);
                  $(".muuri-new-column").removeClass("border-dashed border-gray-700 border-2");

                  if (!receivingList.parents(".muuri-new-column").hasClass("used-column")){
                    console.log("Showing when dropping into empty-column");
                    // $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y );
                    // $( "#new-column" ).sortable(sortableOptions);
                    // $( ".items" ).sortable(sortableOptionsOther);
                    receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
                  }
                  // console.log(receivingList.parents(".muuri-new-column"));
                  // $grid.packery();

                },
                sort: function(event, ui){
                  console.log("SORTABLE OTHER: SORT");
                  // $grid.packery();
                },
                appendTo: 'body',
                placeholder: "ui-sortable-placeholder"

            }


            if ($('.items').length>0){
              console.log("SORTABLE OTHER: INIT");
              $( ".items" ).sortable(sortableOptionsOther);

              }





        // const grid = new Muuri('#test-columns',{
        //     items: '.muuri-new-column',
        //     layoutDuration: 400,
        //     layoutEasing: 'ease',
        //     dragEnabled: true,
        //     dragSortInterval: 0,
        //     dragSortGroup: 'column',
        //     dragSortWith: 'column',
        //     dragContainer: document.body,
        //     dragReleaseDuration: 400,
        //     dragReleaseEasing: 'ease',
        //     dragStartPredicate: {
        //        distance: 10,
        //        delay: 1,
        //        handle: '.muuri-handle'
        //      },
        //      // Layout
        //      layout: {
        //       fillGaps: true
        //     }
        //
        //
        //   }). on('dragReleaseEnd', function(){
        //
        //     grid.refreshItems().layout(function (items) {
        //       // console.log('layout updated!');
        //     });
        //     //recalculateOrder(grid);
        //     //console.log(serializeLayout(grid));
        //
        //
        //   });



        function rebuildData(){

          console.log("REBUILD DATA");



          var data = [];

          console.log($(".items"));

          $(".items").each(function(index, value){

            console.log("For every item getting card list");



            data[index] = $(this).sortable('toArray');


            if ($(this).children().length > 0 && !$(this).hasClass("full-container")){

              console.log("If an item has children and is empty-column, adding used-column AND refreshing packery layout");

              $(this).addClass("full-container");
              $(this).removeClass("h-32");

              $(this).parents(".muuri-new-column").addClass("bg-gray-300 used-column");
              $(this).parents(".muuri-new-column").removeClass("empty-column");

              // $grid.packery('shiftLayout');
              $grid.packery('reloadItems');


            }

          });

          // $grid.packery();

          if($('.empty-column').length < 1 ){

            console.log("No empty column exists, adding a new one");

            tempElement = '<div class="muuri-new-column mt-0 w-64 absolute rounded bg-gray-200 empty-column">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>';

              // $("#test-columns").append(element);
              var $tempElement = $(tempElement);
              $('#test-columns').append($tempElement).packery('appended',$tempElement);

              $grid.packery('reloadItems');
              // $grid.packery();
              // $grid.packery('shiftLayout');
              // $grid.packery('reloadItems');
              // $grid.packery('reloadItems');





              // var $grid = $('#test-columns').packery({
              //   itemSelector: '.muuri-new-column',
              //   // columnWidth helps with drop positioning
              //   columnWidth: 256,
              //
              //   gutter:10
              // });

              // console.log($('.empty-column')[0]);

              //
              $tempElement.each(makeEachDraggable);
              //

              // $grid.packery( 'fit', $('.empty-column')[0]);

              $( "#new-column" ).sortable(sortableOptions);
              $( ".items" ).sortable(sortableOptionsOther);





          }



        }



  $("#new_result").submit(function(e){

      e.preventDefault(); //prevent submit
      // console.log("Submit from result js");
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
      //console.log(submit_time);

      var time_spent = submit_time - Number(localStorage.getItem('init_time'));

      // console.log(typeof(Number(localStorage.getItem('init_time'))));

      // console.log(Number(localStorage.getItem('init_time')));


      // console.log(typeof(time_spent));
      // console.log(time_spent);
      data.name = "testJSONname";
      data.time = time_spent;

      $(".items").each(function(index, value){

        //update array with items
        // console.log(this);
        // just checking if input is found and value pulled - yes
        if($(this).parents('.column-holder').find('.container-name').val()){
          // console.log($(this).parents('.column-holder').find('.container-name').val());
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

      // console.log(data);

      // console.log(JSON.stringify(data));

      // add data to data input before submit
      $('#result_data').val(JSON.stringify(data));

      self.submit(); //submit after data is compiled



  });

// console.log(packery);

  // var = new Packery( '#test-columns', {
  //   // options
  //   itemSelector: '.muuri-new-column',
  //   gutter: 10
  // });

  $.bridget( 'packery', Packery, $ );

  var $grid = $('#test-columns').packery({
    itemSelector: '.muuri-new-column',
    // columnWidth helps with drop positioning
    columnWidth: 256,
    columnHeight: 152,
    gutter: 10
  });

  var pckry = Packery.data('#test-columns');




  console.log("pckry: ");
  console.log(pckry);


  // var $items = $('.muuri-new-column').draggable();
  //
  // $grid.packery( 'bindUIDraggableEvents', $items );

  function makeEachDraggable( i, itemElem ) {
    // make element draggable with Draggabilly
    var draggie = new Draggabilly( itemElem );
    // bind Draggabilly events to Packery
    // console.log("MAKE DRAGGABLE");
    // console.log(itemElem);
    console.log("THIS IS $GRID in make draggable: ");
    console.log($grid);
    $grid.packery( 'bindDraggabillyEvents', draggie );
  }

  $('#test-columns').find('.muuri-new-column').each(makeEachDraggable);
  // $('.muuri-new-column').each(makeEachDraggable);
  // $grid.find('.muuri-new-column').each( function( i, gridItem ) {
  //   var draggie = new Draggabilly( gridItem );
  //   // bind drag events to Packery
  //   $grid.packery( 'bindDraggabillyEvents', draggie );
  // });

  var isActive = true;


  $('.plus').click(function(event){
    event.preventDefault();
    var container = $(this).closest(".column-holder").children(".items");
    container.children(".item").clone().appendTo(container);
    container.removeClass('h-32');
    $grid.packery('shiftLayout');

  });


  $('.make-draggable').click(function(e){
    e.preventDefault();
    $('.muuri-new-column').each(makeEachDraggable);

  });


  $('.add-group').click(function(event){

    // var $grid = $('#test-columns').packery({
    //   itemSelector: '.muuri-new-column',
    //   // columnWidth helps with drop positioning
    //   columnWidth: '.muuri-sizer',
    //   gutter:10
    // });

    console.log($grid);
    console.log("GET ITEM ELEMENTS:");
    console.log($grid.packery('getItemElements'));


    // $grid.packery('destroy');
    event.preventDefault();
    // var element = '<div class="muuri-new-column mt-0 w-64 absolute rounded bg-gray-200 empty-column"><div class="column-holder"><div class="group-header hidden bg-white p-2"><div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div><a href="#" class="name-link py-1 inline-block">Add a name</a><input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/><a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a></div><div class="items p-2 h-32"><div id="20" class="item bg-white px-3 py-3 shadow m-2 rounded"><div class="hidden drag-handle"><i class="fa fa-arrows"></i></div><div class="nested-field"><div class="field mb-0 text-sm cursor-default"><p>Test 1</p><p class="hidden order">3</p></div></div></div></div><a href="#" class="plus">plus</a></div></div>';
    var element = '<div class="muuri-new-column bg-gray-200"></div>';
    var $element = $(element);

    $('#test-columns').append($element).packery('appended', $element);

    // $('#test-columns').append($element);
    //
    // var $grid = $('#test-columns').packery({
    //   itemSelector: '.muuri-new-column',
    //   // columnWidth helps with drop positioning
    //   columnWidth: '.muuri-sizer',
    //   gutter:10
    // });
    $grid.packery('reloadItems');
    $grid.packery('layout');

    console.log("GET ITEM ELEMENTS:");
    console.log($grid.packery('getItemElements'));

    var pckry = Packery.data('#test-columns');

    $element.each(makeEachDraggable);

    // $('#test-columns').packery('appended', $element)
    // $('#test-columns').append($element);
    // var $grid = $('#test-columns').packery({
    //   itemSelector: '.muuri-new-column',
    //   // columnWidth helps with drop positioning
    //   columnWidth: '.muuri-sizer',
    //
    //   gutter:10
    // });

    // $grid.packery( 'fit', $element);
    // $grid.packery('layout');
    // $grid.packery('reloadItems');



    // $('.muuri-new-column').each(makeEachDraggable);
    // $element.each(makeEachDraggable);
    // $grid.find('.muuri-new-column').each( function( i, gridItem ) {
    //   var draggie = new Draggabilly( gridItem );
    //   // bind drag events to Packery
    //   $grid.packery( 'bindDraggabillyEvents', draggie );
    // });


    // var pckry = Packery.data('#test-columns');

    console.log("pckry: ");
    console.log(pckry);

  });




  $('.refresh').click(function(event){
    event.preventDefault();
    // $grid.packery('destroy'); // destroy
    // $grid.packery('shiftLayout');
    // $grid.packery( 'fit', $('.empty-column')[0]);
    // $grid.packery();
    // $grid.packery('reloadItems');

    if (isActive) {
      console.log("Packery is active, destroying");

      $grid.packery('destroy'); // destroy
    } else {
      console.log("Packery is INACTIVE, INIT");
      $grid.packery({
        itemSelector: '.muuri-new-column',
        // columnWidth helps with drop positioning
        columnWidth: '.muuri-sizer',
        gutter:10
      });
      $grid.packery();
      $grid.packery('reloadItems');
      $grid.find('.muuri-new-column').each( function( i, gridItem ) {
        var draggie = new Draggabilly( gridItem );
        // bind drag events to Packery
        $grid.packery( 'bindDraggabillyEvents', draggie );
      });


    }
    // set flag
    isActive = !isActive;

  });






});
