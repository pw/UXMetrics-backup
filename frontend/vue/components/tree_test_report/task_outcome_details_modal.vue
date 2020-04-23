<template>
  <div class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
    <div x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0" x-transition:enter-end="opacity-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100" x-transition:leave-end="opacity-0" class="fixed inset-0 transition-opacity">
      <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
    </div>

    <div x-transition:enter="ease-out duration-300" x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100" x-transition:leave="ease-in duration-200" x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100" x-transition:leave-end="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-5xl sm:w-full max-h-full overflow-y-auto">
      <div class="border-b border-gray-200 px-4 py-5 sm:px-6">
        <h2 class="text-lg leading-6 font-medium text-gray-900">Task {{ task_index + 1 }}</h2>
        <p class="mt-1 text-sm leading-5 text-gray-500">{{ task.instructions }}</p>
      </div>
      <div class="px-4 py-5 sm:p-6">
        <h3 v-show="outcome == 'indirect_correct'" class="text-md leading-6 font-medium text-gray-900 mb-6">{{ task.percent_navigated_indirectly_to_correct_rounded }}% of participants navigated indirectly to the correct link(s). Of those:</h3>
        <h3 v-show="outcome == 'direct_incorrect'" class="text-md leading-6 font-medium text-gray-900 mb-6">{{ task.percent_navigated_directly_to_incorrect_rounded }}% of participants navigated directly to an incorrect link. Of those:</h3>  
        <h3 v-show="outcome == 'indirect_incorrect'" class="text-md leading-6 font-medium text-gray-900 mb-6">{{ task.percent_navigated_indirectly_to_incorrect_rounded }}% of participants navigated indirectly to an incorrect link. Of those:</h3>  
        <h3 v-show="outcome == 'indirect_skip'" class="text-md leading-6 font-medium text-gray-900 mb-6">{{ task.percent_skipped_indirectly_rounded }}% of participants navigated the tree before skipping this task. Of those:</h3>                     
        <div class="flex flex-col">
          <div class="-my-2 py-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
            <div class="align-middle inline-block min-w-full shadow overflow-hidden sm:rounded-lg border-b border-gray-200">
              <table class="min-w-full">
                <tbody class="bg-white">
                  <tr 
                  v-for="result in outcome_summary"
                  >
                    <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200 text-sm leading-5 font-medium text-gray-900">{{ result[1] }}% did this:
                    </td>    
                    <td class="px-6 py-4 whitespace-no-wrap border-b border-gray-200 text-sm leading-5 text-gray-500">
                      <div class="flex w-full bg-gray-100 overflow-x-auto rounded-md h-8 px-2 py-1">
                        <span class="self-center ml-2 block text-sm leading-5 text-gray-700">
                          <NavigationHistory
                          :navigation_history="result[0].split(',')"
                          :outcome="outcome"
                          />
                        </span>
                      </div>
                    </td>                             
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
        <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
          <button @click="$emit('close')" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
            Close
          </button>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import NavigationHistory from './navigation_history.vue'
export default {
  props: {
    task: Object,
    task_index: Number,
    outcome: String,
    outcome_summary: Array
  },
  components: { NavigationHistory }
}
</script>