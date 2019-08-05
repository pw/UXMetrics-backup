// var $ = require("jquery");

var jQuery = require("jquery");
import $ from 'jquery';
window.jQuery = $;
window.$ = $;
const d3 = require('d3/dist/d3');
const britecharts = require('britecharts/dist/bundled/britecharts.min');
const miniTooltip = require('britecharts/src/charts/mini-tooltip');
var _ = require('lodash');

const footable = require('footable/dist/footable.all.min');


// $(document).on('turbolinks:load', function(){
document.addEventListener("turbolinks:load", function() {

console.log("turbolinks:load");
//console.log(dataCompiled);

var element = '<a href="">See more (<span></span>)</a>';

$(".categories-list").each(function(index){
  // console.log("Index: "+index);
  // console.log($(this).children().length);
  var tdMirrorElement = $(this).parent().parent().find("ul.counts-list");
  if($(this).children().length > 3){
    // console.log("yes");
    $(this).parent().append('<ul class="collapsed-list hidden"></ul>');
    $(this).parent().append(element);

    tdMirrorElement.parent().append('<ul class="collapsed-counts-list text-gray-300"></ul>');
    // console.log($(this).parent().children('a').children('span'));

    $(this).parent().on('click', 'a', function(e){
      e.preventDefault();
      $(this).siblings('.collapsed-list').toggle();
      // console.log("click");
    });

    $(this).parent().children('a').children('span').text($(this).children().length - 3);
    $(this).children().each(function(index){
      // console.log("Index2: "+index);
      if(index>4){
        // console.log($(this).parent().parent().children('.collapsed-list'));
        $(this).appendTo($(this).parent().parent().children('.collapsed-list'));
        // console.log(tdMirrorElement.children().eq(index));
        console.log("Index to move: "+index);
        console.log(tdMirrorElement.parent().children('.collapsed-counts-list'));
        tdMirrorElement.children().eq(index).appendTo(tdMirrorElement.parent().children('.collapsed-counts-list'));

        // $(this).appendTo($(this).parent().parent().children('.collapsed-list'));

      }
    });
  }

  // tdMirrorElement


});

const entries = Object.entries(dataCompiled);
console.log(entries );

for (const [count, resultString] of entries) {



  try {
    var result = JSON.parse(JSON.parse(resultString));
  } catch (e) {
    console.log("Some result data is invalid JSON");
    console.log(e);
  }




}

console.log(result.groups);

  const container = d3.select('.bar-container');
  const barChart = britecharts.bar();


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

console.log("Highest group number: "+mostGroups);
var i;
var totalResults = 0;

for (i=1; i <= mostGroups; i++) {
  var count = groupsPerResult.filter(j => j === i).length;
  console.log("Index: "+i);
  console.log("Count: "+count);
  barData.push({"name": i, "value": count});
  totalResults = totalResults+count;
}

console.log(totalResults);
// create percentage array for chart
const barDataPercent = [];

for (i=0; i < barData.length; i++) {

  //console.log(barData[i]);

  var percent = 100*barData[i].value / totalResults;
  var percentRounded =  Math.round( percent * 10 ) / 1000;
  barDataPercent.push({"name":i+1, "value":percentRounded})

}


console.log(barDataPercent);



var tooltip = miniTooltip();

  barChart
      .margin({left: 30})
      .percentageAxisToMaxRatio(1.5)
      .height(400)
      .width(500)
      .isAnimated(true)
      .on('customMouseOver', tooltip.show)
      .on('customMouseMove', tooltip.update)
      .on('customMouseOut', tooltip.hide)
      .xAxisLabel("Number of groups created")
      .xAxisLabelOffset(35);

  container.datum(barDataPercent).call(barChart);

  tooltip.numberFormat('.1%');

  var tooltipContainer = d3.select('.bar-chart .metadata-group');
  tooltipContainer.datum([]).call(tooltip);


  const redrawChart = () => {
      const newContainerWidth = container.node() ? container.node().getBoundingClientRect().width : false;

      // Setting the new width on the chart
      barChart.width(newContainerWidth);

      // Rendering the chart again
      container.call(barChart);
  };
  redrawChart();
  const throttledRedraw = _.throttle(redrawChart, 200);




  window.addEventListener("resize", throttledRedraw);

//

  $(".table").footable({
    "columns": [{"sortable":false}]
  });

});
