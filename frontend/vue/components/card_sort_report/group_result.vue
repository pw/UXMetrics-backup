<template>
  <tr class="bg-white align-top" :class="{'bg-white' : (row_index % 2 === 0), 'bg-gray-50': (row_index % 2 === 1)}">
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      <input v-if="merged_groups.length === 0" @click="$emit('toggleSelectedGroup', group_id, name)" type="checkbox">
    </td>
    <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
      {{ name }}
      <a v-if="merged_groups.length > 0" @click="$emit('manageMergedGroup', group_id, name, merged_groups)">
        <svg class="inline ml-1 h-5 w-5 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
          <path d="M7 9C7 7.89543 7.89543 7 9 7H15C16.1046 7 17 7.89543 17 9V15C17 16.1046 16.1046 17 15 17H9C7.89543 17 7 16.1046 7 15V9Z"/>
          <path d="M5 3C3.89543 3 3 3.89543 3 5V11C3 12.1046 3.89543 13 5 13L5 5H13C13 3.89543 12.1046 3 11 3H5Z"/>
        </svg>
      </a>
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
    group_id: String,
    cards: Array,
    created_by: Number,
    merged_groups: Array,
    row_index: Number
  }
}
</script>