// var $ = require("jquery");

var jQuery = require("jquery");
import $ from 'jquery';
window.jQuery = $;
window.$ = $;
const d3 = require('d3/dist/d3');
const britecharts = require('britecharts/dist/bundled/britecharts.min');




import {GoogleCharts} from 'google-charts';

// var $ = require("jquery");
var jQBridget = require('jquery-bridget');
var Packery = require('packery');

// require("d3-sankey/dist/d3-sankey.min");
// import { sankey } from 'd3-sankey';



//



// import { scaleLinear } from 'd3-scale';
// import { min, max } from 'd3-array';
// import { select } from 'd3-selection';
// import { sankey } from 'd3-sankey';




// console.log(Sankey);


const miniTooltip = require('britecharts/src/charts/mini-tooltip');
var _ = require('lodash');





const footable = require('footable/dist/footable.all.min');

var tableActive = "cards";

// $(document).on('turbolinks:load', function(){
document.addEventListener("turbolinks:load", function() {

console.log("turbolinks:load");
//console.log(dataCompiled);



// GoogleCharts.load(drawChart);
GoogleCharts.load('current', {'packages':['sankey'], 'callback': drawChart});


function drawChart() {
      drawBasic();
      console.log("sankey");
       var data = new google.visualization.DataTable();
       data.addColumn('string', 'From');
       data.addColumn('string', 'To');
       data.addColumn('number', 'Weight');
       data.addColumn({type: 'string', role: 'tooltip', 'p': {'html': true}});

       data.addRows(relationshipData);

       // Sets chart options.
       var options = {

         height: 600,
         sankey: {
           link: {
             color: {

              fillOpacity: 0.2 // Transparency of the link.

            },
            colorMode: 'none'

           },
           node: {label: {
             fontName: 'Heebo',
             fontSize: 14
           }}
         },
         tooltip: { isHtml: true }
       };

       // Instantiates and draws our chart, passing in some options.
       var chart = new google.visualization.Sankey(document.getElementById('sankey'));
       chart.draw(data, options);
     }

// var sankey_chart =
// var chart = d3.select("#chart").append("svg").chart("Sankey");


// var chart = d3.select("#sankey").append("svg").chart("Sankey");

// var sankey = d3.sankey();

// chart.draw(relationshipData);

var element = '<a href="">See more (<span></span>)</a>';

$(".categories-list").each(function(index){

  var expanded = false;

  var categoriesToMove = [];
  var countsToMove = [];

  // console.log("Index: "+index);
  // console.log($(this).children().length);
  var tdMirrorElement = $(this).parent().parent().find("ul.counts-list");
  if($(this).children().length > 3){
    // console.log("yes");
    $(this).parent().append('<ul class="collapsed-list hidden"></ul>');
    $(this).parent().append(element);

    tdMirrorElement.parent().append('<ul class="collapsed-counts-list hidden"></ul>');
    // console.log($(this).parent().children('a').children('span'));

    $(this).parent().on('click', 'a', function(e){
      e.preventDefault();
      $(this).siblings('.collapsed-list').toggle();
      tdMirrorElement.siblings('.collapsed-counts-list').toggle();

      if(expanded == false){
        expanded = true;
        $(this).text("Collapse");
      } else {
        $(this).html("See more (<span></span>)");
        $(this).parent().children('a').children('span').text($(this).parent().children('.collapsed-list').children().length);
        expanded = false;
      }

      // console.log("click");
    });

    $(this).parent().children('a').children('span').text($(this).children().length - 3);
    $(this).children().each(function(index){
      // console.log("Index of categories: "+index);
      if(index>=3){
        // console.log($(this).parent().parent().children('.collapsed-list'));
        // tdMirrorElement.children().eq(index).appendTo(tdMirrorElement.parent().children('.collapsed-counts-list'));
        // var collapsedCountContainer = tdMirrorElement.parent().children('.collapsed-counts-list');
        var countToInsert = tdMirrorElement.children().eq(index);

        countsToMove.push(countToInsert);

        // console.log("Index: "+index);
        // console.log(tdMirrorElement);
        // console.log(countToInsert);

        // countToInsert.appendTo(collapsedCountContainer);

        // countToInswer.a
        // tdMirrorElement.children().eq(index).detach().appendTo(tdMirrorElement.parent().children('.collapsed-counts-list'));
        // tdMirrorElement.children().eq(index).remove();
        var collapsedContainer = $(this).parent().parent().find('.collapsed-list');
        var categoryToInsert = $(this);

        // .children('.collapsed-list')
        // console.log($(this).parent());
        categoryToInsert.appendTo(collapsedContainer);
        // $('ul').append(categoryToInsert);
        // console.log(tdMirrorElement.children().eq(index));
        // console.log("Index to move: "+index);
        // console.log(tdMirrorElement.parent().children('.collapsed-counts-list').children().eq(index));


        // $(this).appendTo($(this).parent().parent().children('.collapsed-list'));

      }
    });
  }

  // tdMirrorElement
  countsToMove.forEach(function(item){
    // console.log(item);
    item.detach().appendTo(tdMirrorElement.parent().children('.collapsed-counts-list'));
  })

});

const entries = Object.entries(dataCompiled);
// console.log(entries );

for (const [count, resultString] of entries) {



  try {
    var result = JSON.parse(JSON.parse(resultString));
  } catch (e) {
    console.log("Some result data is invalid JSON");
    console.log(e);
  }




}


GoogleCharts.load('current', {packages: ['corechart', 'bar']});



function drawBasic() {

      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Groups bucket');

      if (testType == "open"){
        data.addColumn('number', 'Number of people created');
      } else {
        data.addColumn('number', 'Number of people used');
      }


      console.log(barData);

      data.addRows(barData);

      var options = {
        hAxis: {
          gridlines: {
            count: 0
          },
          minorGridlines: {
            count: 0
          },
          ticks: [5,10,15,20]
        },
        vAxis: {
          title: 'Number of people'
        },
        bar: {groupWidth: "55%"},
        legend: { position: "none"},
        fontName: 'Heebo',
        fontSize: 14,
        height: 300,
        backgroundColor: "#f7fafc",
        chartArea: {left:50,top:50,width:'85%',height:'75%'}
      };

      var chart = new google.visualization.ColumnChart(
        document.getElementById('bar-container'));

      chart.draw(data, options);
    }

// console.log(result.groups);

  // const container = d3.select('.bar-container');
  // const barChart = britecharts.bar();


  // const barData = [
  //     { name: 'Luminous', value: 2 },
  //     { name: 'Glittering', value: 5 },
  //     { name: 'Intense', value: 4 },
  //     { name: 'Radiant', value: 3 }
  // ];

  const barData = [];

//console.log(groupsPerResult);

// groupsPerResult.forEach(function(element, index) {
//   console.log(element);
//   // barData.push({"name": index+1, "value": element});
//
//   barData.push({"name": index+1, "value": element});
//
// });

const mostGroups = Math.max.apply(null, groupsPerResult);

// console.log("Highest group number: "+mostGroups);
var i;
var totalResults = 0;

for (i=1; i <= mostGroups; i++) {
  var count = groupsPerResult.filter(j => j === i).length;
  // console.log("Index: "+i);
  // console.log("Count: "+count);

  if (i == 1){
    barData.push([i+" group",count]);
  } else {
    barData.push([i+" groups",count]);
  }


  totalResults = totalResults+count;
}

// console.log(totalResults);
// create percentage array for chart
const barDataPercent = [];

for (i=0; i < barData.length; i++) {

  //console.log(barData[i]);

  var percent = 100*barData[i].value / totalResults;
  var percentRounded =  Math.round( percent * 10 ) / 1000;
  barDataPercent.push([i+1, percentRounded])

}


// console.log(barDataPercent);



// var tooltip = miniTooltip();
//
//   barChart
//       .margin({left: 30})
//       .percentageAxisToMaxRatio(1.5)
//       .height(400)
//       .width(500)
//       .isAnimated(true)
//       .on('customMouseOver', tooltip.show)
//       .on('customMouseMove', tooltip.update)
//       .on('customMouseOut', tooltip.hide)
//       .xAxisLabel("Number of groups created")
//       .xAxisLabelOffset(35);
//
//   container.datum(barDataPercent).call(barChart);
//
//   tooltip.numberFormat('.1%');
//
//   var tooltipContainer = d3.select('.bar-chart .metadata-group');
//   tooltipContainer.datum([]).call(tooltip);
//
//
//   const redrawChart = () => {
//       const newContainerWidth = container.node() ? container.node().getBoundingClientRect().width : false;
//
//       // Setting the new width on the chart
//       barChart.width(newContainerWidth);
//
//       // Rendering the chart again
//       container.call(barChart);
//   };
//   redrawChart();
//   const throttledRedraw = _.throttle(redrawChart, 200);
//
//
//
//
//   window.addEventListener("resize", throttledRedraw);


//


  var $grid = $('.grid').packery({
    itemSelector: '.grid-item',
    gutter: 10,
    transitionDuration: 0
  });


  $(".tab").click(function(e){
    $grid.packery();
  });

  $(".table").footable({

  });

  $(".table-tabs a").click(function(e){
    e.preventDefault();
    if(!$(this).hasClass('active')){
      $(".table-tabs a").removeClass("active");
      $(this).addClass("active");

      console.log(tableActive);

      if ($(this).text() == "View cards"){
        $('.individual-results').hide();
        $('.categories-table').hide();
        $('.cards-table').show();
      } else if ($(this).text() == "View groups") {
        $('.individual-results').hide();
        $('.cards-table').hide();
        $('.categories-table').show();

      } else if ($(this).text() == "Individual results") {


        $('.cards-table').hide();
        $('.categories-table').hide();
        $('.individual-results').show();
        $grid.packery();

      }

      //
      // if (tableActive == "cards"){
      //   tableActive = "categories";
      //   $('.cards-table').hide();
      //   $('.categories-table').show();
      // } else {
      //   tableActive = "cards";
      //   $('.categories-table').hide();
      //   $('.cards-table').show();
      // }
    }

  });

  $(window).resize(function(){
    drawChart();
  });



  $(".merge").click(function(e){
    var selected = [];
    $(".groups-listed table").empty();

    $(".group-checkbox:checked").each(function() {
      selected.push($(this).attr('name'));
      var el = "<tr><td><input type='checkbox' id='"+$(this).attr('id')+"' name='"+$(this).attr('name')+"' checked/></td><td><strong>"+$(this).attr('name')+"</strong></td></tr>"
      $(".groups-listed table").append(el);
    });
    console.log(selected);

  });

  $(".merge-form").on("submit", function(e){
  // $(".merge-form").submit(function(e){
  // alert("dsa");
  e.preventDefault();
    var mg = [];
    mg[0] = $("#merged-name").val();
    mg[1] = [];

    $(".groups-listed input[type='checkbox']:checked").each(function() {
      mg[1].push($(this).attr('name'));
    });

    $("#cardtest_mergedgroups").val("{"+JSON.stringify(mg)+"}");
    // $("#cardtest_mergedgroups").val("['test']");

    $.ajax({
      url: this.action,
      type: "post",
      data: $(this).serialize(),
      success: function(data) {
        console.log(data)
      },
      error: function(data) {
        alert("error");
      }
    });

    e.preventDefault();

    // this.submit();
  });



});
