<template>
  <Modal
  v-show="show"
  :show="show"
  @close="$emit('close')"
  >
    <div class="px-4 py-5 sm:p-6">
      <div>
        <div class="mb-6 mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100">
          <svg class="h-6 w-6 text-red-600" stroke="currentColor" fill="none" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
          </svg>
        </div>
        <p class="text-center">
          {{ error_message }}
        </p>
      </div>
    </div>  
  </Modal>    
</template>

<script>
  import Modal from './modal.vue'

  export default {
    props: {
      show: Boolean,
      error_message: String
    },
    components: { Modal }
  }
</script>