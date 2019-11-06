/* eslint no-console:0 */

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))

require("@rails/ujs").start()
require("turbolinks").start()

require("../../node_modules/font-awesome/css/font-awesome.css");
import('jquery-ui/ui/widgets/sortable');



import "../stylesheets/application.css"
import "../../node_modules/font-awesome/css/font-awesome.css";
import "../../node_modules/britecharts/dist/css/britecharts.css"

import 'd3/dist/d3';
import 'britecharts/dist/bundled/britecharts.min';

const sortable = require('jquery-ui/ui/widgets/sortable');


  var $ = require("jquery");
  require("jquery-ui");

  var jQuery = require("jquery");
  window.jQuery = $;
  window.$ = $;

const footable = require('footable/dist/footable.all.min');

// $(document).on('load', function(){
$(document).on('turbolinks:load', function(){

  $(".admin-table").footable({

  });


console.log("App.js");




  import('jquery-ui/ui/widgets/sortable');

if ($('#editable-cards').length>0){
  $( "#editable-cards" ).sortable({
             update: function(event, ui) {
                var itemOrder = $(this).sortable('toArray');

                var itemsContainer = $('#editable-cards');
                recalculateOrder(itemsContainer);
             },
              handle: '.drag-handle'
          });

  }


  // add events for recalc to add and remove

  $(document).on('click', 'a[data-action="click->nested-form#remove_association"]', function(e) {
    e.preventDefault;
    var itemsContainer = $('#editable-cards');
    recalculateOrder(itemsContainer);
    itemsContainer.sortable( "refresh" );



  });


  $(document).on('click', 'a[data-action="click->nested-form#add_association"]', function(e) {
    e.preventDefault;
    console.log("add stimulus and recalc called");


    var itemsContainer = $('#editable-cards');
    itemsContainer.sortable( "refresh" );
    var itemsContainer = $('#editable-cards');
    recalculateOrder(itemsContainer);

  });


  $(document).on('keypress', '.card-input', function(e) {

    console.log("keypresssss");
    e.preventDefault;


    var keycode = (event.keyCode ? event.keyCode : event.which);
     if(keycode == '13'){
       var itemsContainer = $('#editable-cards');
       itemsContainer.sortable( "refresh" );
       var itemsContainer = $('#editable-cards');
       recalculateOrder(itemsContainer);
       console.log("add stimulus and recalc called");
     }



  });



















function addFullContainer(){



  if ($('.items').length > 0){

  }
}


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
      $(this).parents(".muuri-new-column").addClass("bg-indigo-600");
      $(this).parents(".muuri-new-column").removeClass("bg-indigo-200");
      $(this).parents(".column-holder").prepend('<input type="text" class="container-name" placeholder="Add a name for your group ..."/>')
      //console.log("length is: "+$(this).children().length);

    }

  });

  console.log("this is the data");
  console.log(data);
}

function getCursorPosition(){
  var currentMousePos = { x: -1, y: -1 };
   $(document).mousemove(function(event) {
       currentMousePos.x = event.pageX;
       currentMousePos.y = event.pageY;
       //createTempColumn(currentMousePos.x,currentMousePos.y);
       //console.log(currentMousePos.x,currentMousePos.y);
   });
}

function createTempColumn(){
  //$('.card-column').append("<div class='new-column bg-indigo-900 m-6'></div>");
}


  var itemContainers = $('.new-column');
  var columnGrids = [];
 var boardGrid;

// Add this when rest is working
//$( "#columns" ).sortable();


//InitGrid();


$(".header-nav .coming-soon").click(function(e){
  e.preventDefault();
});


if ($("#homepage-signup")){
  $("#homepage-signup").click(function(e){
    e.preventDefault();
    Turbolinks.visit($(this).attr('href')+"?"+$("#email").val())
  });
}


//Intercept form submit and resubmit with compiled data








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

    var unsaved = true;
    console.log("unsaved to true");
    $(".save-btn").show();

  }








});

import "controllers"
