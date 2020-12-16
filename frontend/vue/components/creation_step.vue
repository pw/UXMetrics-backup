<template>
  <main class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex flex-wrap">  
        <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">
          <div class="bg-none text-sm leading-5 text-gray-600" role="alert">
            <p>{{ instructions }}</p>
          </div>           
        </div>
        <div class="w-full md:w-2/3 xl:w-3/5">
          <div class="shadow sm:rounded-md sm:overflow-hidden">
            <div class="px-4 py-5 bg-white sm:p-6">
              <slot></slot>
            </div>
            <SaveAndContinue @click="$emit('next')" />            
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import SaveAndContinue from './creation_save_and_continue.vue'

export default {
  props: {
    instructions: String
  },
  components: { SaveAndContinue }
}
</script>