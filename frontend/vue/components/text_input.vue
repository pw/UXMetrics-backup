<template>
  <div class="sm:col-span-4">
      <label :for="id" class="block text-sm font-medium leading-5 text-gray-700">{{ label }}</label>
      <p class="mb-2 text-sm text-gray-500">{{ instructions }}</p>
      <div class="mt-1 relative rounded-md shadow-sm">
          <input 
          :id="id" 
          ref="input" 
          class="form-input block w-full sm:text-sm sm:leading-5" 
          :class="{'opacity-50 cursor-not-allowed': disabled}" 
          :disabled="disabled" 
          :placeholder="placeholder" 
          :value="value" 
          @input="$emit('input', $event.target.value)" 
          @blur="$emit('blur')" />
      </div>
  </div>    
</template>

<script>
export default {
  props: {
    id: String,
    label: String,
    instructions: String,
    placeholder: String,
    value: String,
    disabled: {
      type: Boolean,
      default: false
    }
  }
}
</script>