<template>
  <div>
    <div class="flex flex-wrap">
      <select @change="filter" id="tasks" class="block w-full sm:w-1/3 lg:w-1/5 sm:mr-6 transition duration-150 ease-in-out sm:text-sm sm:leading-5 mb-6">
        <option value="all">All Tasks</option>
        <option
        v-for="(task, index) in tasks"
        :key="task.id"
        :value="task.id"
        >
          Task {{ index + 1 }} 
        </option>
      </select>
      <select @change="filter" id="outcomes" class="block w-full sm:w-1/3 lg:w-1/5 transition duration-150 ease-in-out sm:text-sm sm:leading-5 mb-6">
        <option value="all">All Outcomes</option>
        <option value="direct_correct">Direct Success</option>
        <option value="indirect_correct">Indirect Success</option>
        <option value="direct_incorrect">Direct Failure</option>
        <option value="indirect_correct">Indirect Failure</option>
        <option value="direct_skip">Direct Skip</option>
        <option value="indirect_skip">Indirect Skip</option>
      </select>
    </div>  
    <div class="flex flex-col">
      <div class="-my-2 py-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">  
        <div class="align-middle inline-block min-w-full shadow overflow-hidden sm:rounded-lg border-b border-gray-200"> 
        </div> 
          <table class="min-w-full">
            <thead>
              <tr>
                <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Participant</th>
                <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Success Score</th>
                <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Time Taken</th>
                <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Tasks Completed</th>
                <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>              
            </thead>
            <tbody>
              <tr 
              v-for="(participant, index) in participants_local"
              :class="{'bg-white': (index % 2 == 0), 'bg-gray-50': (index % 2 != 0)}">
                <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
                  <a @click="$emit('open', participant, participant.participant_id)">Participant {{ participant.participant_id }}</a>
                </td>
                <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                  {{ participant.success_score }}%
                </td>
                <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                  {{ participant.time_taken }}
                </td>
                <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-500">
                  {{ participant.tasks_completed }}%
                </td>
                <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 font-medium">
                  <span class="inline-flex rounded-md shadow-sm mr-2">
                    <button @click="$emit('open', participant, participant.participant_id)" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                      <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 12C11.1046 12 12 11.1046 12 10C12 8.89543 11.1046 8 10 8C8.89544 8 8.00001 8.89543 8.00001 10C8.00001 11.1046 8.89544 12 10 12Z"/>
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M0.457764 10C1.73202 5.94291 5.52232 3 9.99997 3C14.4776 3 18.2679 5.94288 19.5422 9.99996C18.2679 14.0571 14.4776 17 9.99995 17C5.52232 17 1.73204 14.0571 0.457764 10ZM14 10C14 12.2091 12.2091 14 10 14C7.79087 14 6.00001 12.2091 6.00001 10C6.00001 7.79086 7.79087 6 10 6C12.2091 6 14 7.79086 14 10Z"/>
                      </svg>
                      View
                    </button>
                  </span>                  
                  <span class="inline-flex rounded-md shadow-sm mr-2">
                    <button v-show="!participant.excluded" @click="exclude_participant(participant.id)" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                      <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM8.70711 7.29289C8.31658 6.90237 7.68342 6.90237 7.29289 7.29289C6.90237 7.68342 6.90237 8.31658 7.29289 8.70711L8.58579 10L7.29289 11.2929C6.90237 11.6834 6.90237 12.3166 7.29289 12.7071C7.68342 13.0976 8.31658 13.0976 8.70711 12.7071L10 11.4142L11.2929 12.7071C11.6834 13.0976 12.3166 13.0976 12.7071 12.7071C13.0976 12.3166 13.0976 11.6834 12.7071 11.2929L11.4142 10L12.7071 8.70711C13.0976 8.31658 13.0976 7.68342 12.7071 7.29289C12.3166 6.90237 11.6834 6.90237 11.2929 7.29289L10 8.58579L8.70711 7.29289Z"/>
                      </svg>
                      Exclude
                    </button>
                    <button v-show="participant.excluded" @click="include_participant(participant.id)" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                      <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z"/>
                      </svg>
                      Include
                    </button>                    
                  </span>
                  <span class="inline-flex rounded-md shadow-sm">
                    <button @click="delete_participant(participant.id)" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-red-300 text-xs leading-4 font-medium rounded text-red-700 bg-red-50 hover:text-red-500 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:text-red-800 active:bg-red-100 transition ease-in-out duration-150">
                      <svg class="-ml-0.5 mr-2 h-4 w-4" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM8.70711 7.29289C8.31658 6.90237 7.68342 6.90237 7.29289 7.29289C6.90237 7.68342 6.90237 8.31658 7.29289 8.70711L8.58579 10L7.29289 11.2929C6.90237 11.6834 6.90237 12.3166 7.29289 12.7071C7.68342 13.0976 8.31658 13.0976 8.70711 12.7071L10 11.4142L11.2929 12.7071C11.6834 13.0976 12.3166 13.0976 12.7071 12.7071C13.0976 12.3166 13.0976 11.6834 12.7071 11.2929L11.4142 10L12.7071 8.70711C13.0976 8.31658 13.0976 7.68342 12.7071 7.29289C12.3166 6.90237 11.6834 6.90237 11.2929 7.29289L10 8.58579L8.70711 7.29289Z"/>
                      </svg>
                      Delete
                    </button>
                  </span>
                </td>              
              </tr>
            </tbody>
          </table>     
          <div class="bg-white px-4 py-3 flex items-center justify-between border-t border-gray-200 sm:px-6">
            <div class="hidden sm:block">
              <p class="text-sm leading-5 text-gray-700">
              Showing
              <span class="font-medium">{{ offset + 1 }}</span>
              to
              <span class="font-medium">{{ offset + participants_local.length }}</span>
              of
              <span class="font-medium">{{ total_participants_local }}</span>
              results
              </p>
            </div>
            <div class="flex-1 flex justify-between sm:justify-end">
              <a @click="previous" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 active:bg-gray-100 active:text-gray-700 transition ease-in-out duration-150">
              Previous
              </a>
              <a @click="next" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:shadow-outline-blue focus:border-blue-300 active:bg-gray-100 active:text-gray-700 transition ease-in-out duration-150">
              Next
              </a>
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
    tasks: Array,
    participants: Array,
    total_participants: Number,
    tree_test_id: Number
  },
  data () {
    return {
      offset: 0,
      participants_local: this.participants,
      participants_archive: { 0: this.participants},
      task_filter: 'all',
      result_filter: 'all',
      total_participants_local: this.total_participants
    }
  },
  methods: {
    next() {
      this.offset += 1
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test_id + '/participants?offset=' + this.offset + '&task=' + this.task_filter + '&result=' + this.result_filter,
        type: 'GET',
        success: (response) => {
          this.participants_local = response['participants']
          this.participants_archive[this.offset] = response['participants']
        }
      })
    },
    previous() {
      this.offset -= 1
      this.participants_local  = this.participants_archive[this.offset]
    },
    filter(element) {
      var task_select = document.getElementById('tasks')
      this.task_filter = task_select.options[task_select.selectedIndex].value

    var result_select = document.getElementById('outcomes')
      this.result_filter = result_select.options[result_select.selectedIndex].value

      if(!((this.task_filter == 'all') ^ (this.result_filter == 'all'))) {
        Rails.ajax({
          url: '/tree_tests/' + this.tree_test_id + '/participants?task=' + this.task_filter + '&result=' + this.result_filter + '&offset=0',
          type: 'GET',
          success: (response) => {
            this.offset = 0
            this.participants_local = response['participants']
            this.total_participants_local = response['total']
            this.participants_archive = { 0: response['participants'] }
          }
        })
      }             
    },
    delete_participant(participant_id) {
      Rails.ajax({
        url: '/tree_test_participants/' + participant_id,
        type: 'DELETE',
        success: () => {
          this.reload_current_page()
        }
      })
    },
    exclude_participant(participant_id){
      var data = new FormData
      data.append('tree_test_participant[excluded]', true)
      Rails.ajax({
        url: '/tree_test_participants/' + participant_id,
        type: 'PATCH',
        data: data,
        success: () => {
          this.reload_current_page()
        }
      })
    },
    include_participant(participant_id){
      var data = new FormData
      data.append('tree_test_participant[excluded]', false)
      Rails.ajax({
        url: '/tree_test_participants/' + participant_id,
        type: 'PATCH',
        data: data,
        success: () => {
          this.reload_current_page()
        }
      })
    },
    reload_current_page() {
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test_id + '/participants?offset=' + this.offset + '&task=' + this.task_filter + '&result=' + this.result_filter,
        type: 'GET',
        success: (response) => {
          if(response['participants'].length === 0) {
            this.offset -= 1
            this.participants_local = this.participants_archive[this.offset]
          } else {          
            this.participants_local = response['participants']        
            this.participants_archive[this.offset] = response['participants']
          }
          this.total_participants_local = response['total']
        }
      })      
    }
  }
}
</script>