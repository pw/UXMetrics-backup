<template>
  <div>
    <Nav :name="card_sort.name" :created_at="card_sort.created_at_day" :id="card_sort.id" test_type="card_sorts" />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end mb-16">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 self-center">
            <Sidebar :test="card_sort" middle_box_description="Unique groups created" :middle_box_value="card_sort.total_groups" />
          </div>
          <div class="w-full md:w-2/3 xl:w-3/5 self-center">
          </div>
        </div>

        <div class="flex flex-wrap">
          <div class="w-full mb-16"> 
            <h2 class="text-2xl mb-4">Detailed Analysis</h2>

            <div class="mb-6">
              <div class="block">
                <div class="border-b border-gray-200 text-gray-500">
                  <nav class="-mb-px flex">
                    <button 
                      @click="tab = 'cards'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'cards' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Cards
                    </button>
                    <button 
                      @click="tab = 'groups'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab === 'groups' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Groups
                    </button>
                    <button 
                      @click="tab = 'individual_results'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab === 'individual_results' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Individual Results
                    </button>                    
                  </nav>
                </div>
              </div>
            </div>  

            <div v-show="tab === 'cards'">
              <div class="flex flex-col">
                <div class="-my-2 py-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
                  <div class="align-top inline-block min-w-full shadow overflow-hidden sm:rounded-lg border-b border-gray-200">
                    <table class="min-w-full">
                      <thead>
                        <tr>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Card</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Sorted into</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider"></th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Agreement score</th>
                        </tr>
                      </thead>
                      <CardResult
                      v-for="(result, index) in card_sort.card_results"
                      :key="result[0]"
                      :name="result[0]"
                      :groups="result[1].groups"
                      :agreement_score="result[1].agreement_score"
                      :row_index="index"
                      />
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <div v-show="tab === 'groups'"> 
              <div class="md:flex md:items-center md:justify-between mb-4">
                <div class="flex-1 min-w-0">
                  <p class="mt-4 flex items-center">
                    <svg class="inline mr-1 h-6 w-6 text-purple-700" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                      <path d="M9.66347 17H14.3364M11.9999 3V4M18.3639 5.63604L17.6568 6.34315M21 11.9999H20M4 11.9999H3M6.34309 6.34315L5.63599 5.63604M8.46441 15.5356C6.51179 13.5829 6.51179 10.4171 8.46441 8.46449C10.417 6.51187 13.5829 6.51187 15.5355 8.46449C17.4881 10.4171 17.4881 13.5829 15.5355 15.5356L14.9884 16.0827C14.3555 16.7155 13.9999 17.5739 13.9999 18.469V19C13.9999 20.1046 13.1045 21 11.9999 21C10.8954 21 9.99995 20.1046 9.99995 19V18.469C9.99995 17.5739 9.6444 16.7155 9.01151 16.0827L8.46441 15.5356Z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    Select conceptually similar groups to merge them.
                  </p>
                </div>
                <span class="shadow-sm rounded-md">
                  <a href="#" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:shadow-outline transition duration-150 ease-in-out" target="_blank">
                    <svg class="-ml-1 mr-2 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                      <path d="M7 9C7 7.89543 7.89543 7 9 7H15C16.1046 7 17 7.89543 17 9V15C17 16.1046 16.1046 17 15 17H9C7.89543 17 7 16.1046 7 15V9Z"/>
                      <path d="M5 3C3.89543 3 3 3.89543 3 5V11C3 12.1046 3.89543 13 5 13L5 5H13C13 3.89543 12.1046 3 11 3H5Z"/>
                    </svg>
                    Merge selected groups
                  </a>
                </span>
              </div>
              <div class="flex flex-col">
                <div class="-my-2 py-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
                  <div class="align-top inline-block min-w-full shadow overflow-hidden sm:rounded-lg border-b border-gray-200">
                    <table class="min-w-full">
                      <thead>
                        <tr>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider"></th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Group Name</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Created by</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Cards added</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Frequency</th>
                        </tr>
                      </thead>
                      <GroupResult
                      v-for="(result, index) in card_sort.group_results"
                      :key="result[0]"
                      :name="result[0]"
                      :cards="result[1].cards"
                      :created_by="result[1].created_by"
                      :row_index="index"
                      />
                    </table>
                  </div>
                </div>
              </div>                
            </div>

            <div v-show="tab === 'individual_results'">     
            </div>            

          </div>         
        </div>

      </div>
    </main>

  </div>
</template>

<script>
import Rails from '@rails/ujs'
import Nav from '../components/tree_test_report/nav.vue'
import Sidebar from '../components/tree_test_report/sidebar.vue'
import CardResult from '../components/card_sort_report/card_result.vue'
import GroupResult from '../components/card_sort_report/group_result.vue'

export default {
  props: {
    data: {
      type: Array
    }
  },  
  data () {
    return {
      card_sort: this.data[0],
      tab: 'cards'     
    }
  },
  created: function() {
  },
  methods: {
  },
  components: { Nav, Sidebar, CardResult, GroupResult }
}  
</script>