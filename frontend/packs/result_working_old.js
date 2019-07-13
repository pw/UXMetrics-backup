const sortable = require('jquery-ui/ui/widgets/sortable');
import Hammer from 'hammerjs/hammer';
import Muuri from 'muuri/dist/muuri';



require("hammerjs");
require("muuri");

  var $ = require("jquery");

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





$(document).on('turbolinks:load', function(){

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

  // $("#test-columns").on('click', '.delete-group', function(){
  //   e.preventDefault();
  //
  //   // TEMP:
  //   $(this).closest(".muuri-new-column").find(".name-link").text("Add a name");
  //   $(this).closest(".muuri-new-column").find("input.name-input").val("");
  //
  //   var nameInput = $(this).closest(".muuri-new-column").find(".name-input");
  //   var items = $(this).closest(".column-holder").find(".item");
  //   // console.log("ITEMS:");
  //   // console.log(items);
  //   // items.remove();
  //
  //   var itemsMoved = items.appendTo(".new-column");
  //   // console.log(itemsMoved);
  //   $(this).closest(".muuri-new-column").removeClass("used-column");
  //   $(this).closest(".muuri-new-column").removeClass("used-column");
  //   $(this).closest(".muuri-new-column").removeClass("bg-gray-300");
  //   $(this).closest(".muuri-new-column").addClass("bg-transparent");
  //
  //   console.log($(this).closest(".muuri-new-column").find(".name-input"));
  //   console.log("setting value");
  //
  //   $(this).closest(".muuri-new-column").find(".group-header").addClass("hidden");
  //   $(this).closest(".muuri-new-column").find(".full-container").removeClass("full-container");
  // });

  // $(".delete-group").click(function(e){
  //   e.preventDefault();
  //
  //   // TEMP:
  //   $(this).closest(".muuri-new-column").find(".name-link").text("Add a name");
  //   $(this).closest(".muuri-new-column").find("input.name-input").val("");
  //
  //   var nameInput = $(this).closest(".muuri-new-column").find(".name-input");
  //   var items = $(this).closest(".column-holder").find(".item");
  //   // console.log("ITEMS:");
  //   // console.log(items);
  //   // items.remove();
  //
  //   var itemsMoved = items.appendTo(".new-column");
  //   // console.log(itemsMoved);
  //   $(this).closest(".muuri-new-column").removeClass("used-column");
  //   $(this).closest(".muuri-new-column").removeClass("used-column");
  //   $(this).closest(".muuri-new-column").removeClass("bg-gray-300");
  //   $(this).closest(".muuri-new-column").addClass("bg-transparent");
  //
  //   console.log($(this).closest(".muuri-new-column").find(".name-input"));
  //   console.log("setting value");
  //
  //   $(this).closest(".muuri-new-column").find(".group-header").addClass("hidden");
  //   $(this).closest(".muuri-new-column").find(".full-container").removeClass("full-container");
  //
  // });




  // $(".name-link").click(function(e){
  //   console.log("name link click");
  //   e.preventDefault();
  //   $(this).hide();
  //   $(this).closest(".group-header").find(".delete-group").hide();
  //   $(this).closest(".group-header").find(".muuri-handle").hide();
  //   $(this).closest(".group-header").find(".name-input").show();
  //   $(this).closest(".group-header").find(".name-input").focus();
  // });

  // $(".name-input").blur(function(e){
  //   if(!$(this).val() == ""){
  //     $(this).closest(".group-header").find(".name-link").text($(this).val());
  //     $(this).hide();
  //     $(this).closest(".group-header").find(".name-link").show();
  //     $(this).closest(".group-header").find(".delete-group").show();
  //     $(this).closest(".group-header").find(".muuri-handle").show();
  //   } else {
  //     $(this).closest(".group-header").find(".name-link").text("Add a name");
  //     $(this).hide();
  //     $(this).closest(".group-header").find(".name-link").show();
  //     $(this).closest(".group-header").find(".muuri-handle").show();
  //     $(this).closest(".group-header").find(".delete-group").show();
  //   }
  //
  //
  // });


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
                  var itemOrder = $(this).sortable('toArray');


                var itemsContainer = $('.new-column');
                recalculateOrder(itemsContainer);
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
                grid.refreshItems().layout(function (items) {
                  // console.log('layout updated!');
                });
              },
              stop: function(event, ui){
                // console.log("stop event");
                grid.refreshItems().layout(function (items) {
                  // console.log('layout updated!');
                });
                //getCursorPosition();
              },
              change: function(event, ui){
                // console.log("change");
                grid.refreshItems().layout(function (items) {
                  // console.log('layout updated!');
                });
              },
              appendTo: 'body',
              placeholder: "ui-sortable-placeholder"

          }


  if ($('.new-column').length>0){
    // console.log("new column present");
    $( ".new-column" ).sortable(sortableOptions);

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
                  grid.refreshItems().layout(function (items) {
                    // console.log('layout updated!');
                  });
                  // receivingList.parents(".muuri-new-column").removeClass("border-dashed border-gray-100 border-2");

                },
                start: function(event, ui){
                  // console.log("start event");
                  console.log($(event));
                  $(".muuri-new-column").css('z-index', 1000);
                  $(event.currentTarget).css('z-index', 9000);
                  $(event.currentTarget).parents(".muuri-new-column").css('z-index', 9000);
                  grid.refreshItems().layout(function (items) {

                  });
                  //getCursorPosition();
                },
                stop: function(event, ui){
                  // console.log("stop event");

                  grid.refreshItems().layout(function (items) {
                    // console.log('layout updated!');
                  });
                  //getCursorPosition();
                },
                change: function(event, ui){
                  // console.log("change event");
                  var receivingList = $(event.target);
                  $(".muuri-new-column").removeClass("border-dashed border-gray-700 border-2");

                  if (!receivingList.parents(".muuri-new-column").hasClass("used-column")){
                    receivingList.parents(".muuri-new-column").addClass("border-dashed border-gray-700 border-2");
                  }
                  // console.log(receivingList.parents(".muuri-new-column"));

                },
                sort: function(event, ui){
                  // console.log("sort");
                },
                appendTo: 'body',
                placeholder: "ui-sortable-placeholder"

            }


    if ($('.items').length>0){
      // console.log("test columns found");
      $( ".items" ).sortable(sortableOptionsOther);

      }




        const grid = new Muuri('#test-columns',{
            items: '.muuri-new-column',
            layoutDuration: 400,
            layoutEasing: 'ease',
            dragEnabled: true,
            dragSortInterval: 0,
            dragSortGroup: 'column',
            dragSortWith: 'column',
            dragContainer: document.body,
            dragReleaseDuration: 400,
            dragReleaseEasing: 'ease',
            dragStartPredicate: {
               distance: 10,
               delay: 1,
               handle: '.muuri-handle'
             },
             // Layout
             layout: {
              fillGaps: true
            }


          }). on('dragReleaseEnd', function(){

            grid.refreshItems().layout(function (items) {
              // console.log('layout updated!');
            });
            //recalculateOrder(grid);
            //console.log(serializeLayout(grid));


          });



        function rebuildData(){


          var data = [];

          $(".items").each(function(index, value){
            //update array with items
            console.log("Window rebuild this: ");
            // console.log(this);
            data[index] = $(this).sortable('toArray');

            // console.log("THIS");
            // console.log($(this));

            // console.log("ITEM DROPPED IN");
            // console.log("THIS CHILDREN length:");
            // console.log($(this).children().length > 0);
            // console.log("FULL CONTINER:");
            // console.log(!$(this).hasClass("full-container"));
            //add full container where needed
            if ($(this).children().length > 0 && !$(this).hasClass("full-container")){

              $(this).addClass("full-container");
              $(this).removeClass("h-32");
              // console.log("ADD USED COLUMN AND GRAY BG");
              $(this).parents(".muuri-new-column").addClass("bg-gray-300 used-column");
              // $(this).parents(".muuri-new-column").removeClass("bg-indigo-200");

              // $(this).parents(".column-holder").children(".group-header").append('<input type="text" class="w-4/5 container-name input-small inline-block" placeholder="Add a name for your group ..."/>')
              //console.log("length is: "+$(this).children().length);

            }

          });

          var usedNo = 0;
          var unusedNo = 0;

          $(".muuri-new-column").each(function(index, value){

            if ($(this).hasClass("used-column")) {
              usedNo++;
            } else {
              unusedNo++;
            }



          });

          // console.log("used:");
          // console.log(usedNo);
          // console.log("unused:");
          // console.log(unusedNo);

          if (unusedNo < 3) {
            // $("#test-columns").append('<div class="muuri-new-column py-6 bg-indigo-200 m-6 w-64 absolute"><div class="column-holder"><div class="muuri-handle"><i class="fa fa-arrows-alt"></i></div><div class="items p-4"></div></div></div>');
            // var element = $('<div class="muuri-new-column m-2 mt-0 w-64 absolute"><div class="column-holder"><div class="group-header hidden"><div class="muuri-handle inline-block"><i class="fa fa-arrows-alt"></i></div></div><div class="items p-2"></div></div></div>').appendTo("#test-columns")
            var element = $('<div class="muuri-new-column m-2 mt-0 w-64 absolute rounded"><div class="column-holder"><div class="group-header hidden bg-white p-2"><div class="muuri-handle inline-block text-xs text-gray-500"><i class="fa fa-arrows-alt"></i></div><a href="#" class="name-link py-1 inline-block">Add a name</a><input type="text" class="py-1 name-input w-full container-name input-small inline-block hidden" placeholder="Add a name for your group ..."/><a href="#" class="delete-group float-right text-sm pt-1 pr-1"><i class="fa fa-trash" aria-hidden="true"></i></a></div><div class="items p-2 h-32"></div></div></div>').appendTo("#test-columns")
            // add new item
            grid.add(element[0]);
            // console.log("re init sortable:")

            $( ".items" ).sortable(sortableOptionsOther);
            // grid.add([element]);
          }

          // console.log("this is the data");
          // console.log(data);
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


});
