<template>
  <div class="bg-white overflow-hidden shadow rounded-lg mb-6">
    <div class="border-b border-gray-200 px-4 py-5 sm:px-6">    
      <h3 class="text-lg leading-6 font-medium text-gray-900">Task {{ index + 1}}</h3>
      <p class="mt-1 text-sm leading-5 text-gray-500">{{ task.instructions }}</p>
    </div>    
    <div class="px-4 py-5 sm:p-6">
      <div class="flex flex-wrap">
        <div class="w-full md:w-1/2 md:pr-6">
          <div 
          v-for="choice in task.tree_test_task_correct_choices"
          :key="choice.id"
          class="flex w-full bg-gray-100 overflow-x-auto rounded-md h-8 px-2 py-1 mb-2">
            <span class="self-center ml-2 block text-sm leading-5 text-gray-700">
              <ul class="flex flex-no-wrap">
                <li 
                v-for="(node, index) in choice.path.split(',')"
                :class="{ 'text-green-500 font-bold': index == (choice.path.split(',').length - 1) }"
                class="flex-none">
                    {{ node }}<span v-show="index != (choice.path.split(',').length - 1)"class="mx-2">&rarr;</span>
                </li>
              </ul>
            </span> 
          </div>  
          <div class="max-w-4xl mx-auto">
            <div class="rounded-lg bg-white sm:grid sm:grid-cols-3">
              <div class="border-b border-gray-100 p-6 text-center sm:border-0 sm:border-r">
                <p class="text-2xl leading-none font-semibold text-indigo-600">{{ task.percent_success_formatted }}</p>
                <p class="mt-2 text-md leading-6 font-medium text-gray-500">Success Score</p>
              </div>
              <div class="border-b border-gray-100 p-6 text-center sm:border-0 sm:border-r">
                <p class="text-2xl leading-none font-semibold text-indigo-600">{{ task.directness_formatted }}</p>
                <p class="mt-2 text-md leading-6 font-medium text-gray-500">Directness</p>
              </div>
              <div class="border-b border-gray-100 p-6 text-center sm:border-0 sm:border-r">
                <p class="text-2xl leading-none font-semibold text-indigo-600">{{ task.median_time_formatted }}</p>
                <p class="mt-2 text-md leading-6 font-medium text-gray-500">Median Time</p>
              </div>                          
            </div>
          </div>                
        </div>
        <div class="w-full md:w-1/2 self-start">
          <p class="mb-2 text-md leading-6 font-medium text-gray-500">Score Breakdown</p>
          <div class="w-full mb-6 h-8">
            <div class="h-8 bg-green-500" :style="{ width: task.percent_navigated_directly_to_correct_rounded + '%'}" style="width: %; display: inline-block; float: left;"></div>
            <div class="h-8 bg-green-300" :style="{ width: task.percent_navigated_indirectly_to_correct_rounded + '%'}" style="display: inline-block; float: left;"></div>   
            <div class="h-8 bg-red-500" :style="{ width: task.percent_navigated_directly_to_incorrect_rounded + '%'}" style="display: inline-block; float: left;"></div>   
            <div class="h-8 bg-red-300" :style="{ width: task.percent_navigated_indirectly_to_incorrect_rounded + '%'}" style="display: inline-block; float: left;"></div>             
            <div class="h-8 bg-gray-500" :style="{ width: task.percent_skipped_directly_rounded + '%'}" style="display: inline-block; float: left;"></div>
            <div class="h-8 bg-gray-300" :style="{ width: task.percent_skipped_indirectly_rounded + '%'}" style="display: inline-block; float: left;"></div>  
          </div> 

          <div class="flex mb-3">
            <div class="flex-initial mr-2">
              <span class="inline-block h-4 w-4 rounded-full bg-green-500"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">{{ task.percent_navigated_directly_to_correct_rounded }}% navigated directly to the correct link(s).</p>
            </div>
          </div>                          

          <div class="flex mb-3">
            <div class="flex-initial mr-2" >
              <span class="inline-block h-4 w-4 rounded-full bg-green-300"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">
                <a @click="$emit('openTaskOutcomeModal', task.id, 'indirect_correct')">{{ task.percent_navigated_indirectly_to_correct_rounded }}% navigated indirectly</a> to the correct link(s).
              </p>
            </div>
          </div>           

          <div class="flex mb-3">
            <div class="flex-initial mr-2">
              <span class="inline-block h-4 w-4 rounded-full bg-red-500"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">
                <a @click="$emit('openTaskOutcomeModal', task.id, 'direct_incorrect')">{{ task.percent_navigated_directly_to_incorrect_rounded }}% navigated directly</a> to an incorrect link.
              </p>
            </div>
          </div>                                   
          <div class="flex mb-3">
            <div class="flex-initial mr-2">
              <span class="inline-block h-4 w-4 rounded-full bg-red-300"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">
                <a @click="$emit('openTaskOutcomeModal', task.id, 'indirect_incorrect')">{{ task.percent_navigated_indirectly_to_incorrect_rounded }}% navigated indirectly</a> to an incorrect link.
              </p>
            </div>
          </div>

          <div class="flex mb-3">
            <div class="flex-initial mr-2">
              <span class="inline-block h-4 w-4 rounded-full bg-gray-500"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">{{ task.percent_skipped_directly_rounded }}% directly skipped this task.</p>
            </div>
          </div>

          <div class="flex mb-3">
            <div class="flex-initial mr-2">
              <span class="inline-block h-4 w-4 rounded-full bg-gray-300"></span>
            </div>
            <div class="flex-initial">
              <p class="text-sm leading-5 text-gray-500">
                <a @click="$emit('openTaskOutcomeModal', task.id, 'indirect_skip')">{{ task.percent_skipped_indirectly_rounded }}% indirectly skipped</a> this task.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>    
  </div>
</template>

<script>
export default {
  props: {
    task: Object,
    index: Number
  }
}
</script>