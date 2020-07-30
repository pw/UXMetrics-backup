<template>
  <tr class="bg-white align-top" :class="{'bg-white' : (row_index % 2 === 0), 'bg-gray-50': (row_index % 2 === 1)}">
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <input @click="$emit('toggleSelectedGroup', name)" type="checkbox">
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ name }}
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ created_by }} {{ (created_by === 1) ? 'Participant' : 'Participants' }}
    </td>    
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(card, index) in cards"
        >
          {{ card[0] }}  
        </li>
      </ul>
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <ul class="pl-0">
        <li
        v-for="(card, index) in cards"
        >
          {{ card[1] }} {{ (card[1] === 1) ? 'time' : 'times' }}
        </li>
      </ul>
    </td>
  </tr>
</template>

<script>
export default {
  props: {
    name: String,
    cards: Array,
    created_by: Number,
    row_index: Number
  }
}
</script>