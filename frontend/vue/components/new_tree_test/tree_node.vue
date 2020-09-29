<template>
  <div class="flex items-center justify-between bg-white overflow-hidden shadow rounded-md p-1 mb-2">
    <div v-if="!(item.id == tree[0].id && tree.length == 1) && !disabled" class="mr-1">
      <svg class="h-6 w-6 text-gray-700" fill="currentColor" viewBox="0 0 24 24" stroke="none">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 3C10.2652 3 10.5196 3.10536 10.7071 3.29289L13.7071 6.29289C14.0976 6.68342 14.0976 7.31658 13.7071 7.70711C13.3166 8.09763 12.6834 8.09763 12.2929 7.70711L10 5.41421L7.70711 7.70711C7.31658 8.09763 6.68342 8.09763 6.29289 7.70711C5.90237 7.31658 5.90237 6.68342 6.29289 6.29289L9.29289 3.29289C9.48043 3.10536 9.73478 3 10 3ZM6.29289 12.2929C6.68342 11.9024 7.31658 11.9024 7.70711 12.2929L10 14.5858L12.2929 12.2929C12.6834 11.9024 13.3166 11.9024 13.7071 12.2929C14.0976 12.6834 14.0976 13.3166 13.7071 13.7071L10.7071 16.7071C10.3166 17.0976 9.68342 17.0976 9.29289 16.7071L6.29289 13.7071C5.90237 13.3166 5.90237 12.6834 6.29289 12.2929Z"/>
      </svg>
    </div>    
    <div class="flex-1 min-w-0">
      <div class="rounded-md shadow-sm" :class="{'shadow-none': disabled}">
        <input class="form-input px-2 py-1 block w-full transition duration-150 ease-in-out text-sm font-medium leading-5 text-gray-700" :class="{'border-none': disabled}" :placeholder="placeholder_text"  :value="value" @input="$emit('input', $event.target.value)" @blur="$emit('blur')" />
      </div>
    </div>
    <div class="ml-1">
      <span v-if="!(item.id == tree[0].id && tree.length == 1)  && !disabled" @click="$emit('remove', item.id)" class="inline-flex rounded-md shadow-sm">
        <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-red-700 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
          -
        </button>
      </span>      
      <span @click="$emit('add', item.id)" v-if="!disabled" class="inline-flex rounded-md shadow-sm">
        <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
          +
        </button>
      </span>
    </div>
  </div>  
</template>

<script>
export default {
  props: {
    placeholder_text: String, 
    item: Object,
    tree: Array, 
    value: String, 
    disabled: {
      type: Boolean,
      default: false
    }
  }
}
</script>