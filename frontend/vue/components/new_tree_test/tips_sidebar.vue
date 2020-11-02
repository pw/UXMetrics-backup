<template>
  <div class="" :class="[background_styling, text_styling]" role="alert">
    <p>{{ instructions }}</p>
  </div>
</template>

<script>
export default {
  props: {
    current_step: String,
    total_steps: Number,
    instructions: String,
    background_styling: {
      type: String,
      default: 'bg-none'
    },
    text_styling: {
      type: String,
      default: 'text-sm leading-5 text-gray-600'
    }
  }
}
</script>