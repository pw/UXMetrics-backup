<template>
  <div class="sm:col-span-4">
    <label :for="id" class="block text-sm font-medium leading-5 text-gray-700">
      {{ label }}
    </label>
    <p class="mb-2 text-sm text-gray-500">{{ instructions }}</p>
    <div class="mt-1 rounded-md shadow-sm">
      <textarea :id="id" rows="5" class="form-textarea block w-full transition duration-150 ease-in-out sm:text-sm sm:leading-5" :class="{'opacity-50': disabled}" :disabled="disabled" :value="value" @input="$emit('input', $event.target.value)" @blur="$emit('blur')" >
      </textarea>
    </div>
  </div>	
</template>

<script>
export default {
  props: {
    id: String,
    label: String,
    instructions: String,
    value: String,
    disabled: {
      type: Boolean,
      default: false
    }
  } 
}
</script>