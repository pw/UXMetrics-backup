<template>
  <div>
    <div class="mb-6">
      <div class="block">
        <div class="border-b border-gray-200 text-gray-500">
          <nav class="-mb-px flex">
            <Tab
            v-for="tab in tabs"
            :name="tab"
            :selected="current_tab === tab"
            @changeTab="changeTab"
            />                       
          </nav>
        </div>
      </div>
    </div>              
  </div>  
</template>

<script>
import Tab from './tab.vue'

export default {
  components: { Tab },
  props: {
    tabs: Array,
    current_tab: String
  },
  methods: {
    changeTab(name) {
      this.$emit('changeTab', name)
    }
  }
}
</script>