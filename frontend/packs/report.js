const d3 = require('d3/dist/d3');
const britecharts = require('britecharts/dist/bundled/britecharts.min');

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

for (i=1; i <= mostGroups; i++) {
  var count = groupsPerResult.filter(j => j === i).length;
  console.log("Index: "+i);
  console.log("Count: "+count);
  barData.push({"name": i, "value": count});
}

console.log(barData);





  barChart
      .margin({left: 100})
      .percentageAxisToMaxRatio(1)
      .height(200)
      .width(400);

  container.datum(barData).call(barChart);

//
});
