const d3 = require('d3/dist/d3');
const britecharts = require('britecharts/dist/bundled/britecharts.min');
const miniTooltip = require('britecharts/src/charts/mini-tooltip');
var _ = require('lodash');

// $(document).on('turbolinks:load', function(){
document.addEventListener("turbolinks:load", function() {

console.log("turbolinks:load");
//console.log(dataCompiled);


const entries = Object.entries(dataCompiled);
console.log(entries );

for (const [count, resultString] of entries) {



  try {
    result = JSON.parse(JSON.parse(resultString));
  } catch (e) {
    console.log("Some result data is invalid JSON");
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
  barDataPercent.push({"name":i, "value":percentRounded})

}


console.log(barDataPercent);



tooltip = miniTooltip();

  barChart
      .margin({left: 30})
      .percentageAxisToMaxRatio(1.5)
      .height(400)
      .width(500)
      .isAnimated(true)
      .on('customMouseOver', tooltip.show)
      .on('customMouseMove', tooltip.update)
      .on('customMouseOut', tooltip.hide);

  container.datum(barDataPercent).call(barChart);

  tooltip.numberFormat('.1%');

  tooltipContainer = d3.select('.bar-chart .metadata-group');
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
});
