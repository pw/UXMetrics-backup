<template>
  <div class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
    <transition name="overlay">
      <div v-show="show" class="fixed inset-0 transition-opacity">
        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
      </div>
    </transition>

    <transition name="modal">
      <div v-show="show" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-5xl sm:w-full max-h-full overflow-y-auto">
        <div class="flex items-center justify-between flex-wrap sm:flex-no-wrap border-b border-gray-200 px-4 py-5 sm:px-6">
          <h2 class="text-lg leading-6 font-medium text-gray-900">Merge Groups</h2>
          <button @click="$emit('close')" type="button" class="text-gray-400 hover:text-gray-500 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150">
            <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>          
        </div>
        <div class="px-4 py-5 sm:p-6">
          <label for="name" class="block text-sm font-medium leading-5 text-gray-700">Name</label>
          <div class="mt-1 mb-4 relative rounded-md shadow-sm">
            <input id="name" class="form-input block w-full sm:text-sm sm:leading-5" placeholder="Create a name for this merged group..." />
          </div>
          <div class="flex flex-col">
            <label for="name" class="block text-sm font-medium leading-5 text-gray-700">Merge these groups:</label>
            <div v-for="group in groups" :key="group" class="flex items-center">
              <input id="group_1" type="checkbox" checked class="form-checkbox h-4 w-4 text-purple-600 transition duration-150 ease-in-out" />
              <label for="group_1" class="ml-2 block text-sm leading-5 text-gray-900">
                  {{ group }}
              </label>
            </div>
          </div>
        </div>
        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <span class="mt-3 sm:ml-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
            <button  type="button" class="inline-flex justify-center w-full rounded-md border border-transparent px-4 py-2 text-base leading-6 font-medium rounded-md text-white shadow-sm bg-purple-600 hover:bg-purple-500 focus:outline-none focus:shadow-outline transition duration-150 ease-in-out sm:text-sm sm:leading-5">
              Merge Selected Groups
            </button>
          </span>
          <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
            <button @click="$emit('close')" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
              Cancel
            </button>
          </span>
        </div>        
      </div>
    </transition>
  </div>
</template>

<script>

export default {
  props: {
    show: Boolean,
    groups: Array
  },
}
</script>