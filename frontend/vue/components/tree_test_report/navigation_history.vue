<template>
  <span>
    <span v-if="outcome === 'direct_skip'">Skipped</span>
    <span v-else>      
      <ul class="flex flex-no-wrap">
        <li 
        v-for="(node, index) in navigation_history"
        :class="[(index == (navigation_history.length - 1) ? color() + ' font-bold' : '')]"
        class="flex-none">
            {{ node }}<span v-show="index != (navigation_history.length - 1)"class="mx-2">&rarr;</span>
        </li>         
      </ul>
    </span>
 </span>
</template>

<script>
export default {
  props: {
    navigation_history: Array,
    outcome: {
      type: String,
      default: 'direct_correct'
    }
  },
  methods: {
    color() {
      switch(this.outcome) {
        case 'direct_correct':
          return 'text-green-500'
          break
        case 'indirect_correct':
          return 'text-green-500'
          break
        case 'direct_incorrect':
          return 'text-red-500'
          break
        case 'indirect_incorrect':
          return 'text-red-500'
          break
        case 'indirect_skip':
          return 'text-gray-500'
          break
      }
    }
  },  
}
</script>