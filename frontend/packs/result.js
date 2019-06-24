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

  console.log("recalc");
  $(this).find('.item').each(function( index, value ) {
    console.log("cycling through items: "+index);
    $(this).find("input[name*='order']").val(index);
    $(this).find("p.order").html(index);
  });

  $(itemsContainer).each(function(){
    console.log("Container found");
    $(this).find('.item').each(function( index, value ) {
      $(this).find("input[name*='order']").val(index);
      $(this).find("p.order").html(index);
    });

  });


}



$(document).on('turbolinks:load', function(){

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
              handle: '.drag-handle',
              out: function(event, ui){
                console.log("Out event");

              },
              start: function(event, ui){
                console.log("start event");
                //getCursorPosition();
                grid.refreshItems().layout(function (items) {
                  console.log('layout updated!');
                });
              },
              stop: function(event, ui){
                console.log("stop event");
                grid.refreshItems().layout(function (items) {
                  console.log('layout updated!');
                });
                //getCursorPosition();
              },
              change: function(event, ui){
                console.log("change");
                grid.refreshItems().layout(function (items) {
                  console.log('layout updated!');
                });
              }

          }


  if ($('.new-column').length>0){
    console.log("new column present");
    $( ".new-column" ).sortable(sortableOptions);

    }

    //connect

    var sortableOptionsOther = {
              connectWith: ".new-column, .items",
              zIndex: 10000,
              dropOnEmpty: true,
              update: function(event, ui) {
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
                handle: '.drag-handle',
                out: function(event, ui){
                  console.log("Out event");

                },
                start: function(event, ui){
                  console.log("start event");
                  grid.refreshItems().layout(function (items) {
                    console.log('layout updated!');
                  });
                  //getCursorPosition();
                },
                stop: function(event, ui){
                  console.log("stop event");

                  grid.refreshItems().layout(function (items) {
                    console.log('layout updated!');
                  });
                  //getCursorPosition();
                }

            }


    if ($('.items').length>0){
      console.log("test columns found");
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
           }
        }). on('dragReleaseEnd', function(){

          grid.refreshItems().layout(function (items) {
            console.log('layout updated!');
          });
          //recalculateOrder(grid);
          //console.log(serializeLayout(grid));


        });



        function rebuildData(){


          var data = [];

          $(".items").each(function(index, value){
            //update array with items
            console.log("Window rebuild this: ");
            console.log(this);
            data[index] = $(this).sortable('toArray');

            //add full container where needed
            if ($(this).children().length > 0 && !$(this).hasClass("full-container")){
              $(this).addClass("full-container");
              $(this).parents(".muuri-new-column").addClass("bg-indigo-600 used-column");
              $(this).parents(".muuri-new-column").removeClass("bg-indigo-200");
              $(this).parents(".column-holder").prepend('<input type="text" class="container-name" placeholder="Add a name for your group ..."/>')
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

          console.log("used:");
          console.log(usedNo);
          console.log("unused:");
          console.log(unusedNo);

          if (unusedNo < 3) {
            // $("#test-columns").append('<div class="muuri-new-column py-6 bg-indigo-200 m-6 w-64 absolute"><div class="column-holder"><div class="muuri-handle"><i class="fa fa-arrows-alt"></i></div><div class="items p-4"></div></div></div>');
            var element = $('<div class="muuri-new-column py-6 bg-indigo-200 m-6 w-64 absolute"><div class="column-holder"><div class="muuri-handle"><i class="fa fa-arrows-alt"></i></div><div class="items p-4"></div></div></div>').appendTo("#test-columns")
            // add new item
            grid.add(element[0]);
            console.log("re init sortable:")

            $( ".items" ).sortable(sortableOptionsOther);
            // grid.add([element]);
          }

          console.log("this is the data");
          console.log(data);
        }



  $("#new_result").submit(function(e){

      e.preventDefault(); //prevent submit
      console.log("Submit from result js");
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

      console.log(JSON.stringify(data));

      // add data to data input before submit
      $('#result_data').val(JSON.stringify(data));

      self.submit(); //submit after data is compiled



  });


});
