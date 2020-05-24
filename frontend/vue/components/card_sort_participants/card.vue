<template>
<div :class="classes">
  <div class="bg-white overflow-hidden shadow rounded-md p-2 mb-2 cursor-move">
    <div class="flex-1 min-w-0">
      <span class="px-2 py-1 block w-full text-sm font-medium leading-5 text-gray-700">
          {{ title }}
      </span>
      <span v-show="show_description" class="px-2 py-1 block w-full text-sm font-regular leading-5 text-gray-700">
          {{ description }}
      </span>           
    </div>
  </div>
</div>  
</template>

<script>
  export default {
    props: {
      title: String,
      description: String,
      classes: String,
      show_description: {
        type: Boolean, 
        default: true
      }
    }
  }
</script>