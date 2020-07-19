<template>
  <tr class="align-top" :class="{'bg-white' : (row_index % 2 === 0), 'bg-gray-50': (row_index % 2 === 1)}">
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ name }}
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(group, index) in groups"
        v-show="(index <= 2) || show_more"
        >
          {{ group[0] }}  
        </li>
      </ul>
      <a @click="show_more = true" v-show="show_more === false && groups.length > 3">Show more ({{ groups.length - 3 }})</a>
      <a @click="show_more = false" v-show="show_more === true">Show less</a>
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(group, index) in groups"
        v-show="(index <= 2) || show_more"
        >
          {{ group[1] }} {{ (group[1] === 1) ? 'time' : 'times' }}
        </li>
      </ul>
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ agreement_score }}%
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    name: String,
    groups: Array,
    agreement_score: Number, 
    row_index: Number
  },
  data () {
    return {
      show_more: false
    }
  }
}
</script>