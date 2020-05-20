<template>
  <div class="flex items-top justify-between bg-white overflow-hidden shadow rounded-md p-2 mb-3">
    <div class="mr-2 pt-1">
      <svg class="h-6 w-6 text-gray-700" fill="currentColor" viewBox="0 0 24 24" stroke="none">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 3C10.2652 3 10.5196 3.10536 10.7071 3.29289L13.7071 6.29289C14.0976 6.68342 14.0976 7.31658 13.7071 7.70711C13.3166 8.09763 12.6834 8.09763 12.2929 7.70711L10 5.41421L7.70711 7.70711C7.31658 8.09763 6.68342 8.09763 6.29289 7.70711C5.90237 7.31658 5.90237 6.68342 6.29289 6.29289L9.29289 3.29289C9.48043 3.10536 9.73478 3 10 3ZM6.29289 12.2929C6.68342 11.9024 7.31658 11.9024 7.70711 12.2929L10 14.5858L12.2929 12.2929C12.6834 11.9024 13.3166 11.9024 13.7071 12.2929C14.0976 12.6834 14.0976 13.3166 13.7071 13.7071L10.7071 16.7071C10.3166 17.0976 9.68342 17.0976 9.29289 16.7071L6.29289 13.7071C5.90237 13.3166 5.90237 12.6834 6.29289 12.2929Z"/>
      </svg>
    </div>
    <div class="flex-1 min-w-0">
      <div class="rounded-md shadow-sm">
        <input ref="title" v-model="title" @input="$emit('updateCard', card_id, { title: title, description: description, has_description: has_description })" @keyup.enter="$emit('nextCard', card_id)" class="form-input px-2 py-1 block w-full transition duration-150 ease-in-out text-sm font-medium leading-5 text-gray-700" placeholder="Card Label" />
      </div>
      <div v-show="has_description" class="mt-2 rounded-md shadow-sm">
        <textarea v-model="description" @input="$emit('updateCard', card_id, { title: title, description: description, has_description: has_description })" @keyup.enter="$emit('nextCard', card_id)" id="card_description" rows="2" class="form-textarea px-2 py-1 block w-full transition duration-150 ease-in-out text-sm font-medium leading-5 text-gray-700" placeholder="Description">
        </textarea>
      </div>
      <p v-show="has_description" class="mt-2 text-sm font-medium leading-5 text-right">
        <a @click="has_description = false; $emit('updateCard', card_id, { title: title, description: description, has_description: false })" class="text-red-500">Remove Description</a>
      </p>      
    </div>
    <div class="flex ml-2">
      <span class="self-stretch rounded-md mr-2">
        <button v-show="!has_description" @click="has_description = true; $emit('updateCard', card_id, { title: title, description: description, has_description: true })" type="button" class="inline-flex items-center px-2 py-1 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:bg-gray-50 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
          <svg class="h-5 w-5 text-gray-700" fill="currentColor" viewBox="0 0 24 24" stroke="none">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M3 5C3 4.44772 3.44772 4 4 4H16C16.5523 4 17 4.44772 17 5C17 5.55228 16.5523 6 16 6H4C3.44772 6 3 5.55228 3 5Z" />
            <path fill-rule="evenodd" clip-rule="evenodd" d="M3 10C3 9.44772 3.44772 9 4 9H16C16.5523 9 17 9.44772 17 10C17 10.5523 16.5523 11 16 11H4C3.44772 11 3 10.5523 3 10Z" />
            <path fill-rule="evenodd" clip-rule="evenodd" d="M3 15C3 14.4477 3.44772 14 4 14H10C10.5523 14 11 14.4477 11 15C11 15.5523 10.5523 16 10 16H4C3.44772 16 3 15.5523 3 15Z" />
          </svg>
        </button>
      </span>
      <span class="self-stretch rounded-md">
        <button @click="$emit('removeCard', card_id)" type="button" class="inline-flex items-center px-2 py-1 border border-transparent text-xs leading-4 font-medium rounded text-red-500 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
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
      card_id: Number
    },
    data () {
      return {
        title: '',
        description: '',
        has_description: false
      }
    }
  }
</script>