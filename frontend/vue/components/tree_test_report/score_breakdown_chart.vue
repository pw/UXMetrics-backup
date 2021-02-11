<template>
  <div>
    <div class="w-full h-2">
      <div class="h-2 bg-green-500" :style="{ width: Math.floor(tree_test.percent_navigated_directly_to_correct) + '%'}" style="width: %; display: inline-block; float: left;"></div>
      <div class="h-2 bg-green-300" :style="{ width: Math.floor(tree_test.percent_navigated_indirectly_to_correct) + '%'}" style="display: inline-block; float: left;"></div>   
      <div class="h-2 bg-red-500" :style="{ width: Math.floor(tree_test.percent_navigated_directly_to_incorrect) + '%'}" style="display: inline-block; float: left;"></div>   
      <div class="h-2 bg-red-300" :style="{ width: Math.floor(tree_test.percent_navigated_indirectly_to_incorrect) + '%'}" style="display: inline-block; float: left;"></div>             
      <div class="h-2 bg-gray-500" :style="{ width: Math.floor(tree_test.percent_skipped_directly) + '%'}" style="display: inline-block; float: left;"></div>
      <div class="h-2 bg-gray-300" :style="{ width: Math.floor(tree_test.percent_skipped_indirectly) + '%'}" style="display: inline-block; float: left;"></div>              
    </div>
    <div class="w-full">
      <ul class="mt-6 grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-green-500 text-white text-sm font-medium rounded-l-md">
            {{ tree_test.percent_navigated_directly_to_correct }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Direct Success</p>
              <p class="text-gray-500">Direct navigation to correct links.</p>
            </div>
          </div>
        </li>

        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-green-300 text-green-700 text-sm font-medium rounded-l-md">
            {{ tree_test.percent_navigated_indirectly_to_correct }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Indirect Success</p>
              <p class="text-gray-500">Indirect navigation to correct links.</p>
            </div>
          </div>
        </li>

        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-red-500 text-white text-sm font-medium rounded-l-md">
            {{ tree_test.percent_navigated_directly_to_incorrect }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Direct Failure</p>
              <p class="text-gray-500">Direct navigation to incorrect links.</p>
            </div>
          </div>
        </li>

        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-red-300 text-red-700 text-sm font-medium rounded-l-md">
            {{ tree_test.percent_navigated_indirectly_to_incorrect }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Indirect Failure</p>
              <p class="text-gray-500">Indirect navigation to incorrect links.</p>
            </div>
          </div>
        </li>

        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-gray-500 text-white text-sm font-medium rounded-l-md">
            {{ tree_test.percent_skipped_directly }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Direct Skip</p>
              <p class="text-gray-500">Skipped the task without trying.</p>
            </div>
          </div>
        </li>

        <li class="col-span-1 flex shadow-sm rounded-md">
          <div class="flex-shrink-0 flex items-center justify-center w-16 bg-gray-300 text-gray-700 text-sm font-medium rounded-l-md">
            {{ tree_test.percent_skipped_indirectly }}%
          </div>
          <div class="flex-1 flex items-center justify-between border-t border-r border-b border-gray-200 bg-white rounded-r-md truncate">
            <div class="flex-1 px-4 py-2 text-sm truncate">
              <p class="text-gray-900 font-medium hover:text-gray-600">Indirect Skip</p>
              <p class="text-gray-500">Skipped the task after trying.</p>
            </div>
          </div>
        </li>
      </ul>
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