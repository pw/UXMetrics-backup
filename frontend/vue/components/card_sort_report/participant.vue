<template>
  <div class="px-2">
    <div class="bg-white rounded-md shadow-sm px-4 py-5 sm:px-6 mb-6">
      <div class="-ml-4 -mt-4 flex justify-between items-center flex-wrap sm:flex-no-wrap">
        <div class="ml-4 mt-4">
          <h3 class="text-lg leading-6 font-medium text-gray-900">
              Participant {{ participant_id }}
          </h3>
          <p class="mt-1 text-sm leading-5 text-gray-500">
              Time to complete: {{ time_to_complete }}
          </p>
        </div>
        <div class="ml-4 mt-4 flex-shrink-0">
          <span class="inline-flex rounded-md shadow-sm mr-2 hidden">
            <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
              <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z"/>
              </svg>
              Include
            </button>
          </span>
          <span class="inline-flex rounded-md shadow-sm mr-2">
            <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
              <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM8.70711 7.29289C8.31658 6.90237 7.68342 6.90237 7.29289 7.29289C6.90237 7.68342 6.90237 8.31658 7.29289 8.70711L8.58579 10L7.29289 11.2929C6.90237 11.6834 6.90237 12.3166 7.29289 12.7071C7.68342 13.0976 8.31658 13.0976 8.70711 12.7071L10 11.4142L11.2929 12.7071C11.6834 13.0976 12.3166 13.0976 12.7071 12.7071C13.0976 12.3166 13.0976 11.6834 12.7071 11.2929L11.4142 10L12.7071 8.70711C13.0976 8.31658 13.0976 7.68342 12.7071 7.29289C12.3166 6.90237 11.6834 6.90237 11.2929 7.29289L10 8.58579L8.70711 7.29289Z"/>
              </svg>
              Exclude
            </button>
          </span>
          <span class="inline-flex rounded-md shadow-sm">
            <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-red-300 text-xs leading-4 font-medium rounded text-red-700 bg-red-50 hover:text-red-500 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:text-red-800 active:bg-red-100 transition ease-in-out duration-150">
              <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM8.70711 7.29289C8.31658 6.90237 7.68342 6.90237 7.29289 7.29289C6.90237 7.68342 6.90237 8.31658 7.29289 8.70711L8.58579 10L7.29289 11.2929C6.90237 11.6834 6.90237 12.3166 7.29289 12.7071C7.68342 13.0976 8.31658 13.0976 8.70711 12.7071L10 11.4142L11.2929 12.7071C11.6834 13.0976 12.3166 13.0976 12.7071 12.7071C13.0976 12.3166 13.0976 11.6834 12.7071 11.2929L11.4142 10L12.7071 8.70711C13.0976 8.31658 13.0976 7.68342 12.7071 7.29289C12.3166 6.90237 11.6834 6.90237 11.2929 7.29289L10 8.58579L8.70711 7.29289Z"/>
              </svg>
              Delete
            </button>
          </span>
        </div>
      </div>
    </div>
    <div class="flex flex-wrap -mx-2">
      <div 
      v-for="group in sorting"
      :key="group[0]"
      class="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 px-2 mb-4">
        <div class="bg-gray-200 overflow-hidden rounded-lg">
          <div class="p-4">
            <span class="block w-full text-base font-medium leading-5 text-gray-700">
              {{ group[0] }}
            </span>
            <div 
            v-for="card in group[1]"
            :key="card"
            class="flex items-top justify-between bg-white overflow-hidden shadow rounded-md p-2 mt-2">
              <div class="flex-1 min-w-0">
                <span class="px-2 py-1 block w-full text-sm font-medium leading-5 text-gray-700">
                  {{ card }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Rails from '@rails/ujs'

export default {
  props: {
    participant_id: Number,
    participant_database_id: Number,
    card_sort_id: Number
  },
  data () {
    return {
      time_to_complete: null,
      sorting: null
    }
  },
  created() {
    this.update()
  },
  watch: {
    participant_database_id: function (val) {
      this.update()
    }
  },
  methods: {
    update() {
      Rails.ajax({
        url: '/card_sort_participants/' + this.participant_database_id + '?card_sort_id=' + this.card_sort_id,
        type: 'GET',
        success: (arg) => {
          this.time_to_complete = arg.time_to_complete
          this.sorting = arg.sorting
        }
      })
    }
  }
}
</script>