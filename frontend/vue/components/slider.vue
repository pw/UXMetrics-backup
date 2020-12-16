<template>
  <div :class="{'opacity-50': !enabled}">
    <div class="flex items-center justify-between">
      <span class="flex-grow flex flex-col" id="toggleLabel">
        <label for="randomize" class="text-sm font-medium leading-5 text-gray-700">
          {{ label }}
        </label>
        <span class="text-sm leading-normal text-gray-500">
          {{ description }}
        </span>
      </span>
      <span :class="{ 'bg-gray-200': !value, 'bg-purple-600': value, 'focus:outline-none focus:shadow-outline cursor-pointer': enabled }" class="relative inline-flex flex-shrink-0 h-6 w-11 border-2 border-transparent rounded-full transition-colors ease-in-out duration-200" role="checkbox" tabindex="0" @click="toggle" @keydown.space.prevent="toggle" :aria-checked="value">
        <span aria-hidden="true" :class="{ 'translate-x-5': value, 'translate-x-0': !value }" class="inline-block h-5 w-5 rounded-full bg-white shadow transform transition ease-in-out duration-200">
          <span :class="{ 'opacity-0 ease-out duration-100': value, 'opacity-100 ease-in duration-200': !value }" class="absolute inset-0 h-full w-full flex items-center justify-center transition-opacity">
            <svg class="h-3 w-3 text-gray-400" fill="none" viewBox="0 0 12 12">
              <path d="M4 8l2-2m0 0l2-2M6 6L4 4m2 2l2 2" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </span>
          <span :class="{ 'opacity-100 ease-in duration-200': value, 'opacity-0 ease-out duration-100': !value }" class="absolute inset-0 h-full w-full flex items-center justify-center transition-opacity">
            <svg class="h-3 w-3 text-purple-600" fill="currentColor" viewBox="0 0 12 12">
              <path d="M3.707 5.293a1 1 0 00-1.414 1.414l1.414-1.414zM5 8l-.707.707a1 1 0 001.414 0L5 8zm4.707-3.293a1 1 0 00-1.414-1.414l1.414 1.414zm-7.414 2l2 2 1.414-1.414-2-2-1.414 1.414zm3.414 2l4-4-1.414-1.414-4 4 1.414 1.414z" />
            </svg>
          </span>
        </span>
      </span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    label: String,
    description: String,
    value: Boolean,
    enabled: {
      type: Boolean,
      default: true
    }
  },
  methods: {
    toggle() {
      if(this.enabled) {
        this.$emit('input', !this.value)
      }
    } 
  }
}
</script>