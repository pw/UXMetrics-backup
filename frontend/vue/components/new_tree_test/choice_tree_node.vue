<template>
  <div>
    <div v-if="element.children.length == 0" class="flex items-center justify-between bg-white overflow-hidden shadow rounded-md h-8 px-2 py-1 mb-2" :style="{'margin-left': margin + 'rem'}">
      <div class="flex items-center">
        <input type="checkbox" class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out element" :id="element.id" :name="element.id" :checked="isSelected(element.id)" @click="$emit('toggleCorrectChoice', $event.target.id, lineage, element.text)"/> 
        <label :for="element.id" class="ml-2 block text-sm leading-5 text-gray-700 font-bold">{{ element.text }}</label>
      </div> 
    </div>
    <div v-else class="flex items-center justify-between bg-gray-100 overflow-hidden rounded-md h-8 px-2 py-1 mb-2" :style="{'margin-left': margin + 'rem'}">
      <span class="ml-2 block text-sm leading-5 text-gray-700">{{ element.text }}</span>
    </div>
    <Node v-for="child in element.children" :element="child" :key="child.id" :lineage="lineage.concat([element.text])" :margin="margin + 1.5" @toggleCorrectChoice="toggleCorrectChoice" :correct_choice="correct_choice" />
  </div>	
</template>

<script>
export default {
  props: {
    element: Object,
    margin: Number,
    lineage: {
      type: Array,
      default: () => []
    },
    correct_choice: Array
  },
  name: 'Node',
  methods: {
    toggleCorrectChoice(id, lineage, text) {
      this.$emit('toggleCorrectChoice', id, lineage, text)
    },
    isSelected(id) {
      var index = this.correct_choice.findIndex(i => i.id == id)
      if(index == -1) {
        return false
      } else {
        return true
      }
    }
  }
}
</script>