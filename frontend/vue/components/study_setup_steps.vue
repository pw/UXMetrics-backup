<template>
  <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
    <ul class="space-y-4 md:flex md:space-y-0 md:space-x-8">
      <li 
      v-for="(step, index) in steps"
      class="md:flex-1">
        <div 
        class="group pl-4 py-2 block border-l-4 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4"
        :class="{'border-purple-600': (current_step >= (index + 1))}">
          <h3 class="text-xs leading-4 text-purple-600 font-semibold uppercase">Step {{ index + 1 }}</h3>
          <p class="text-sm leading-5 font-medium">{{ step }}</p>
        </div>
      </li>
    </ul>
  </nav>  
</template>

<script>
export default {
  props: {
    steps: Array,
    current_step: Number
  },
  data() {
    return {      
    }
  }
}
</script>