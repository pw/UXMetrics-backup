<template>
  <div>
    <div v-for="task in tasks">
      <div class="bg-white overflow-hidden shadow rounded-lg mb-6">
        <div class="border-b border-gray-200 px-2 py-3 sm:px-4">
          <div class="flex items-center justify-between">
            <span>Task </span>
            <span class="inline-flex rounded-md shadow-sm">
              <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-red-700 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
                -
              </button>
            </span>
          </div>
        </div>
        <div class="px-4 py-5 sm:p-6">
          <div class="flex rounded-md shadow-sm mb-3">
            <textarea rows="3" class="form-textarea block w-full h-20 transition duration-150 ease-in-out sm:text-sm sm:leading-5" :value="task.instructions">
            </textarea>
          </div>
        </div>
      </div>    
    </div>
  </div>
</template>

<script>
export default {
  props: ['tasks'],
  data () {
    return {
    }
  },  
  methods: {
  }  
}
</script>