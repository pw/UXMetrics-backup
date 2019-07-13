const sortable = require('jquery-ui/ui/widgets/sortable');
// const packery = require("packery/js/packery");
// const packery = require("packery/dist/packery.pkgd");

// var Packery = require('packery');

import Hammer from 'hammerjs/hammer';
import Muuri from 'muuri/dist/muuri';



require('jquery-ui/ui/widgets/draggable');
require("hammerjs");
require("muuri");



  var $ = require("jquery");
  var jQBridget = require('jquery-bridget');
  var Packery = require('packery');


function recalculateOrder(itemsContainer){

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
  console.log("debounce");
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


$(document).on('turbolinks:load', function(){

  var draggingItem = false;
  var onDropArea = false;
  var currentMousePos = { x: -1, y: -1 };
  var dragStart = 0;
  var buffer = 150;
  var initPos = 0;


  var dePosition = debounce(function(event) {

    // console.log(event.pageX);


    if(draggingItem == true){

      // console.log(dragStart);
    }
    // console.log((currentMousePos.x - dragStart + 120 > 252));

    // console.log(Math.abs(initPos - currentMousePos.x - dragStart + 120));
    if(draggingItem == true && (currentMousePos.x - dragStart + 120 > 252) && Math.abs(initPos - currentMousePos.x - dragStart + 120) > buffer){

      initPos = currentMousePos.x - dragStart + 120;


      onDropArea = true;


      // console.log($('.muuri-new-column')[0]);


      console.log("calling fit");
      $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y );



    } else {
      onDropArea = false;
    }

  }, 100);


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
                // console.log("Out event");

              },
              start: function(event, ui){
                // console.log("start event");
                //getCursorPosition();
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });

                console.log("start drag");
                dragStart = currentMousePos.x;
                draggingItem = true;




                $grid.packery();
              },
              stop: function(event, ui){
                // console.log("stop event");
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });
                console.log("stop drag");


                draggingItem = false;
                dragStart = 0;



                $grid.packery();

                //getCursorPosition();
              },
              change: function(event, ui){
                // console.log("change");
                // grid.refreshItems().layout(function (items) {
                //   // console.log('layout updated!');
                // });



                $grid.packery();
              },
              receive: function(event, ui)
              {
                console.log("received");
              },
              appendTo: 'body',
              placeholder: "ui-sortable-placeholder"

          }


  if ($('#new-column').length>0){
    // console.log("new column present");
    console.log("adding sortable");
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
                $(".muuri-new-column").removeClass("border-dashed border-gray-100 border-2");
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
                  console.log("Out event");
                  var receivingList = $(event.target);
                  // grid.refreshItems().layout(function (items) {
                  //   // console.log('layout updated!');
                  // });
                  $grid.packery();
                  // receivingList.parents(".muuri-new-column").removeClass("border-dashed border-gray-100 border-2");

                },
                start: function(event, ui){
                  // console.log("start event");
                  console.log($(event));
                  $(".muuri-new-column").css('z-index', 1000);
                  $(event.currentTarget).css('z-index', 9000);
                  $(event.currentTarget).parents(".muuri-new-column").css('z-index', 9000);
                  // grid.refreshItems().layout(function (items) {
                  //
                  // });
                  $grid.packery();
                  //getCursorPosition();
                },
                stop: function(event, ui){
                  // console.log("stop event");

                  // grid.refreshItems().layout(function (items) {
                  //   // console.log('layout updated!');
                  // });
                  $grid.packery();
                  //getCursorPosition();
                },
                change: function(event, ui){
                  // console.log("change event");
                  var receivingList = $(event.target);
                  $(".muuri-new-column").removeClass("border-dashed border-gray-700 border-2");

                  if (!receivingList.parents(".muuri-new-column").hasClass("used-column")){
                    $grid.packery( 'fit', $('.empty-column')[0], currentMousePos.x - dragStart - 240, currentMousePos.y );

                    receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
                  }
                  // console.log(receivingList.parents(".muuri-new-column"));
                  $grid.packery();

                },
                sort: function(event, ui){
                  // console.log("sort");
                  $grid.packery();
                },
                appendTo: 'body',
                placeholder: "ui-sortable-placeholder"

            }


            if ($('.items').length>0){
              // console.log("test columns found");
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





          var element = $('<div class="muuri-new-column mt-0 w-64 absolute rounded bg-gray-200 empty-column">              <div class="column-holder">                <div class="group-header hidden bg-white p-2">                  <div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div>                  <a href="#" class="name-link py-1 inline-block">Add a name</a>                  <input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/>                  <a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a>                </div>                  <div class="items p-2 h-32">                    </div>              </div>            </div>');


          if($('.empty-column').length < 1 ){
            // $("#test-columns").append(element);


            $grid.append(element).packery( 'appended', element);
            $( ".items" ).sortable(sortableOptionsOther);


            var $items = $('.muuri-new-column').draggable();

            $grid.packery( 'bindUIDraggableEvents', $items );

          }






          var data = [];

          $(".items").each(function(index, value){

            console.log("Window rebuild this: ");
            console.log(this);
            data[index] = $(this).sortable('toArray');


            if ($(this).children().length > 0 && !$(this).hasClass("full-container")){

              $(this).addClass("full-container");
              $(this).removeClass("h-32");

              $(this).parents(".muuri-new-column").addClass("bg-gray-300 used-column");
              $(this).parents(".muuri-new-column").removeClass("empty-column");


            }

          });

          $grid.packery();

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
    gutter:10
  });

  var pckry = Packery.data('#test-columns');

  console.log(pckry);


  var $items = $('.muuri-new-column').draggable();

  $grid.packery( 'bindUIDraggableEvents', $items );


});
