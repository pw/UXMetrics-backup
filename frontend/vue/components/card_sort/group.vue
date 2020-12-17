<template>
  <div class="flex items-top justify-between bg-white overflow-hidden shadow rounded-md p-2 mb-3">
    <div v-show="!disabled" class="mr-2 pt-1 cursor-pointer">
      <svg class="h-6 w-6 text-gray-700" fill="currentColor" viewBox="0 0 24 24" stroke="none">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 3C10.2652 3 10.5196 3.10536 10.7071 3.29289L13.7071 6.29289C14.0976 6.68342 14.0976 7.31658 13.7071 7.70711C13.3166 8.09763 12.6834 8.09763 12.2929 7.70711L10 5.41421L7.70711 7.70711C7.31658 8.09763 6.68342 8.09763 6.29289 7.70711C5.90237 7.31658 5.90237 6.68342 6.29289 6.29289L9.29289 3.29289C9.48043 3.10536 9.73478 3 10 3ZM6.29289 12.2929C6.68342 11.9024 7.31658 11.9024 7.70711 12.2929L10 14.5858L12.2929 12.2929C12.6834 11.9024 13.3166 11.9024 13.7071 12.2929C14.0976 12.6834 14.0976 13.3166 13.7071 13.7071L10.7071 16.7071C10.3166 17.0976 9.68342 17.0976 9.29289 16.7071L6.29289 13.7071C5.90237 13.3166 5.90237 12.6834 6.29289 12.2929Z"/>
      </svg>
    </div>
    <div class="flex-1 min-w-0">
      <div :class="{'rounded-md shadow-sm': !disabled}">
        <input ref="input" :class="{'border-none': disabled}" class="form-input px-2 py-1 block w-full transition duration-150 ease-in-out text-sm font-medium leading-5 text-gray-700" @input="$emit('input', $event.target.value)" @blur="$emit('updateGroup', group_id)" @keyup.enter="$emit('nextGroup', group_id)" :value="value" :disabled="disabled" placeholder="Group Name" />
      </div>
    </div>
    <div v-show="!disabled" class="flex ml-2">
      <span class="self-stretch rounded-md">
        <button @click="$emit('remove', group_id)" type="button" class="inline-flex items-center px-2 py-1 border border-transparent text-xs leading-4 font-medium rounded text-red-500 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
          <svg class="h-5 w-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M9 2C8.62123 2 8.27497 2.214 8.10557 2.55279L7.38197 4H4C3.44772 4 3 4.44772 3 5C3 5.55228 3.44772 6 4 6L4 16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V6C16.5523 6 17 5.55228 17 5C17 4.44772 16.5523 4 16 4H12.618L11.8944 2.55279C11.725 2.214 11.3788 2 11 2H9ZM7 8C7 7.44772 7.44772 7 8 7C8.55228 7 9 7.44772 9 8V14C9 14.5523 8.55228 15 8 15C7.44772 15 7 14.5523 7 14V8ZM12 7C11.4477 7 11 7.44772 11 8V14C11 14.5523 11.4477 15 12 15C12.5523 15 13 14.5523 13 14V8C13 7.44772 12.5523 7 12 7Z"/>
          </svg>
        </button>
      </span>
    </div>
  </div>  
</template>

<script>
  export default {
    props: {
      group_id: Number,
      value: String,
      disabled: Boolean
    }
  }
</script>