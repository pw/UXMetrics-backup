<template>
  <button 
    @click="changeTab"
    :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': selected }"
    class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
    {{ name }}
  </button> 
</template>

<script>
export default {
  props: {
    name: String,
    selected: Boolean
  },
  methods: {
    changeTab() {
      this.$emit('changeTab', this.name)
    }
  }
}
</script>