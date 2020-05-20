<template>
  <main class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex flex-wrap">  
        <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">
          <TipsSidebar :current_step="current_step" :total_steps="total_steps" :instructions="instructions" :background_styling="tips_background_styling" :border_styling="tips_border_styling" :text_styling="tips_text_styling"/>  
        </div>
        <div class="w-full md:w-2/3 xl:w-3/5">
          <slot></slot>
        </div>
      </div>
    </div>
  </main>
</template>

<script>
import TipsSidebar from './tips_sidebar.vue'
export default {
  props: ['current_step', 'total_steps', 'instructions', 'tips_background_styling', 'tips_border_styling', 'tips_text_styling'],
  components: { TipsSidebar }
}
</script>