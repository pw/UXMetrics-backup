<template>
  <div>
    <div class="py-4 bg-white rounded shadow px-4 my-4">
      <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.test_results_count }}</p>
      <h4 class="-mt-2 font-semibold px-2 text-center text-gray-500">Results</h4>
    </div>
    <div class="py-4 bg-white rounded shadow px-4 my-4">
      <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.percent_success }}%</p>
      <h4 class="-mt-2 font-semibold px-2 text-center text-gray-500">Average success score</h4>
    </div>
    <div class="py-4 bg-white rounded shadow px-4 my-4">
      <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.median_time }}</p>
      <h4 class="-mt-2 font-semibold px-2 text-center text-gray-500">Median time to complete</h4>              
    </div>    
  </div>
</template>

<script>
export default {
  props: {
    tree_test: Object
  }
}
</script>