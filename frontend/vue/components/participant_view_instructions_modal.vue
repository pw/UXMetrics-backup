<template>
  <Modal
  v-show="show"
  :show="show"
  @close="$emit('close')"
  >
    <div class="flex items-center justify-between flex-wrap sm:flex-no-wrap border-b border-gray-200 px-4 py-5 sm:px-6">
      <h2 class="text-lg leading-6 font-medium text-gray-900">
        Instructions
      </h2>
      <button @click="$emit('close')" type="button" class="text-gray-400 hover:text-gray-500 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150">
        <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>
    <div class="px-4 py-5 sm:p-6">
      <div class="grid grid-cols-1 col-gap-4 row-gap-8 md:grid-cols-2">
        <div class="sm:col-span-1">
          <div class="mb-6">
            <p class="mb-3">
              We'd like you to categorize the cards at the bottom of the screen cards into groups that make sense to you. You can do this by dragging and dropping them into the area above.
            </p>
            <p class="mb-3">
                There are no right or wrong answers, just do what makes sense to you!
            </p>
            <p>
              When you're finished, click the green "Submit" button at the top right.
            </p>
          </div>
        </div>
        <div class="sm:col-span-1">
          <div class="bg-gray-200 overflow-hidden rounded-lg text-center h-full">
            <div class="px-4 py-5 sm:p-6">
              Demo GIF will go here
            </div>
          </div>
        </div>
      </div>
    </div>
  </Modal>    
</template>

<script>
  import Modal from './modal.vue'

  export default {
    props: {
      show: Boolean
    },
    components: { Modal }
  }
</script>