<template>
  <tr class="bg-white align-top">
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ name }}
    </td>
    <td x-data="{show_more: false" class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(group, index) in groups"
        v-show="(index <= 1) || show_more"
        >
          {{ group[0] }}  
        </li>
      </ul>
      <a @click="show_more = true" v-show="show_more === false && groups.length > 2">Show more ({{ groups.length - 2 }})</a>
      <a @click="show_more = false" v-show="show_more === true">Show less</a>
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(group, index) in groups"
        v-show="(index <= 1) || show_more"
        >
          {{ group[1] }} times
        </li>
      </ul>
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ agreement_score * 100 }}%
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    name: String,
    groups: Array,
    agreement_score: Number
  },
  data () {
    return {
      show_more: false
    }
  }
}
</script>