<template>
  <div>
    <h2 class="text-2xl mb-4">
        Aggregate Score Breakdown (All Tasks)
    </h2> 
    <div class="w-full mb-6 h-10">
      <div class="h-10 bg-green-500" :style="{ width: Math.floor(tree_test.percent_navigated_directly_to_correct) + '%'}" style="width: %; display: inline-block; float: left;"></div>
      <div class="h-10 bg-green-300" :style="{ width: Math.floor(tree_test.percent_navigated_indirectly_to_correct) + '%'}" style="display: inline-block; float: left;"></div>   
      <div class="h-10 bg-red-500" :style="{ width: Math.floor(tree_test.percent_navigated_directly_to_incorrect) + '%'}" style="display: inline-block; float: left;"></div>   
      <div class="h-10 bg-red-300" :style="{ width: Math.floor(tree_test.percent_navigated_indirectly_to_incorrect) + '%'}" style="display: inline-block; float: left;"></div>             
      <div class="h-10 bg-gray-500" :style="{ width: Math.floor(tree_test.percent_skipped_directly) + '%'}" style="display: inline-block; float: left;"></div>
      <div class="h-10 bg-gray-300" :style="{ width: Math.floor(tree_test.percent_skipped_indirectly) + '%'}" style="display: inline-block; float: left;"></div>              
    </div>              
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-green-500">
            <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_directly_to_correct }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
            Participants navigated directly to correct links {{ tree_test.percent_navigated_directly_to_correct }}% of the time.
        </p>
      </div>
    </div>    
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-green-300">
          <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_indirectly_to_correct }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
              Participants navigated indirectly to correct links {{ tree_test.percent_navigated_indirectly_to_correct }}% of the time.
        </p>
      </div>
    </div> 
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-red-500">
          <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_directly_to_incorrect }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
              Participants navigated directly to incorrect links {{ tree_test.percent_navigated_directly_to_incorrect }}% of the time.
        </p>
      </div>
    </div>          
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-red-300">
          <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_indirectly_to_incorrect }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
            Participants navigated indirectly to incorrect links {{ tree_test.percent_navigated_indirectly_to_incorrect }}% of the time.
        </p>
      </div>
    </div>
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-500">
          <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_skipped_directly }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
            Participants directly skipped tasks {{ tree_test.percent_skipped_directly }}% of the time.
        </p>
      </div>
    </div>
    <div class="flex mb-4">
      <div class="flex-initial mr-2">
        <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-300">
          <span class="text-md font-medium leading-none text-gray-500">{{ tree_test.percent_skipped_indirectly }}%</span>
        </span>
      </div>
      <div class="flex self-center">
        <p class="text-md leading-5 text-gray-500">
                Participants indirectly skipped tasks {{ tree_test.percent_skipped_indirectly }}% of the time.
        </p>
      </div>  
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