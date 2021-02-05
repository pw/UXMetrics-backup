<template>
  <div>
    <transition name="modal-component">
      <div v-show="show" class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
        <transition name="overlay">
          <div v-show="show" class="fixed inset-0 transition-opacity">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
          </div>
        </transition>

        <transition name="modal">
          <div v-show="show" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-xl sm:w-full max-h-full overflow-y-auto">
            <slot></slot>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
                <button @click="$emit('close')" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
                  Close
                </button>
              </span>
            </div>
          </div>
        </transition>
      </div>       
    </transition>    
  </div>
</template>

<script>
  export default {
    props: {
      show: Boolean
    }
  }
</script>