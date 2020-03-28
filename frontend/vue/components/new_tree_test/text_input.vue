<template>
  <div class="sm:col-span-4">
      <label :for="id" class="block text-sm font-medium leading-5 text-gray-700">{{ label }}</label>
      <div class="mt-1 relative rounded-md shadow-sm">
          <input :id="id" class="form-input block w-full sm:text-sm sm:leading-5" :class="{'opacity-50': disabled, 'cursor-not-allowed': disabled}" :placeholder="placeholder" :value="value" @input="$emit('input', $event.target.value)" @blur="$emit('blur')" />
      </div>
  </div>    
</template>

<script>
export default {
  props: {
    id: {
      type: String
    },
    label: {
      type: String
    },
    placeholder: {
      type: String
    },
    value: {
      type: String
    },
    disabled: {
      type: Boolean,
      default: false
    }
  }
}
</script>