<template>
  <div>
    <Nav :name="card_sort.name" :created_at="card_sort.created_at_day" :id="card_sort.id" test_type="card_sorts" />
    
    <div class="py-6 border-b bg-orange-50 text-gray-900">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:flex lg:items-center lg:justify-between">
          <div class="flex justify-between">
            <svg class="flex-initial mr-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path d="M10 2a5 5 0 00-5 5v2a2 2 0 00-2 2v5a2 2 0 002 2h10a2 2 0 002-2v-5a2 2 0 00-2-2H7V7a3 3 0 015.905-.75 1 1 0 001.937-.5A5.002 5.002 0 0010 2z" />
            </svg>
            <h5 class="flex-1 text-sm mb-6 lg:mb-0">
              This report is public. It can be viewed by anyone with the link. (<a href="'/' + test_type + '/' + id + '/edit'" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)
            </h5>
          </div>
          <div class="md:flex md:items-center md:justify-between">
            <h5 class="text-sm mr-2 font-bold">Share:</h5>
            <div class="flex rounded-md shadow-sm w-full">
              <div class="relative flex-grow focus-within:z-10">
                <input id="email" class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" url />
              </div>
              <button v-clipboard:copy="card_sort.collect_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
                <svg class="h-5 w-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M9 2C7.89543 2 7 2.89543 7 4V12C7 13.1046 7.89543 14 9 14H15C16.1046 14 17 13.1046 17 12V6.41421C17 5.88378 16.7893 5.37507 16.4142 5L14 2.58579C13.6249 2.21071 13.1162 2 12.5858 2H9Z"/>
                  <path d="M3 8C3 6.89543 3.89543 6 5 6V16H13C13 17.1046 12.1046 18 11 18H5C3.89543 18 3 17.1046 3 16V8Z"/>
                </svg>
                <span class="ml-2">Copy</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="py-6 border-b bg-orange-50 text-gray-900">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:flex lg:items-center lg:justify-between">
          <div class="flex justify-between">
            <svg class="mr-1 inline h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
            <h5 class="flex-1 text-sm">
              This report is private. Only you can view it. (<a href="'/' + test_type + '/' + id + '/edit'" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)
            </h5>
          </div>
        </div>
      </div>
    </div>

    <div class="py-6 border-b bg-orange-50 text-gray-900">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:flex lg:items-center lg:justify-between">
          <div class="flex justify-between">
            <svg class="flex-initial mr-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path d="M10 2a5 5 0 00-5 5v2a2 2 0 00-2 2v5a2 2 0 002 2h10a2 2 0 002-2v-5a2 2 0 00-2-2H7V7a3 3 0 015.905-.75 1 1 0 001.937-.5A5.002 5.002 0 0010 2z" />
            </svg>
            <h5 class="flex-1 text-sm mb-6 lg:mb-0">
              This report is private. Only you and those with the password can view it. (<a href="'/' + test_type + '/' + id + '/edit'" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)
            </h5>
          </div>
          <div class="md:flex md:items-center md:justify-between">
            <h5 class="text-sm mr-2 font-bold">Share:</h5>
            <div class="flex rounded-md shadow-sm w-full">
              <div class="relative flex-grow focus-within:z-10">
                <input id="email" class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" url />
              </div>
              <button v-clipboard:copy="card_sort.collect_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
                <svg class="h-5 w-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                  <path d="M9 2C7.89543 2 7 2.89543 7 4V12C7 13.1046 7.89543 14 9 14H15C16.1046 14 17 13.1046 17 12V6.41421C17 5.88378 16.7893 5.37507 16.4142 5L14 2.58579C13.6249 2.21071 13.1162 2 12.5858 2H9Z"/>
                  <path d="M3 8C3 6.89543 3.89543 6 5 6V16H13C13 17.1046 12.1046 18 11 18H5C3.89543 18 3 17.1046 3 16V8Z"/>
                </svg>
                <span class="ml-2">Copy</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end mb-16">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 self-center">
            <Sidebar :test="card_sort" middle_box_description="Unique groups created" :middle_box_value="card_sort.total_groups" />
          </div>
          <div class="w-full md:w-2/3 xl:w-3/5 self-center">
            <h2 @click="draw_chart" class="text-2xl mb-4">Groups Created</h2>
            <canvas id="bar-chart"></canvas>
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
                      :name="result[1].name"
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
                  <a @click="new_merge_group_modal_open = true" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:shadow-outline transition duration-150 ease-in-out cursor-pointer">
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
                      :group_id="result[0]"
                      :name="result[1].name"
                      :cards="result[1].cards"
                      :created_by="result[1].created_by"
                      :merged_groups="result[1].merged_groups"
                      :row_index="index"
                      @manageMergedGroup="manageMergedGroup"
                      @toggleSelectedGroup="toggleSelectedGroup"
                      />
                    </table>
                  </div>
                </div>
              </div>                
            </div>

            <div v-show="tab === 'individual_results'">
              <div class="sm:block mb-6 overflow-x-auto">
                <nav class="flex">
                  <a 
                  v-for="participant in card_sort.participants" 
                  :key="participant[1]" 
                  class="flex-shrink-0 px-3 py-2 font-medium text-sm leading-5 rounded-md cursor-pointer" 
                  :class="{ 'text-purple-700 bg-purple-100 focus:outline-none focus:text-purple-800 focus:bg-purple-200': (participant[0] === current_participant_id), 'text-gray-500 hover:text-gray-700 focus:outline-none focus:text-purple-600 focus:bg-purple-50': (participant[0] !== current_participant_id)}"
                  aria-current="page"
                  @click="current_participant_id = participant[0]; current_participant_database_id = participant[1]"
                  >
                      Participant {{ participant[0] }}
                  </a>                    
                </nav>               
              </div>  
              <Participant
                :participant_id="current_participant_id"
                :participant_database_id="current_participant_database_id"
                :card_sort_id="card_sort.id"
                @dataChange="update_card_sort_data"
              />             
            </div>            

          </div>         
        </div>

        <div class="flex flex-wrap">
          <div class="w-full mb-16">
            <h2 class="text-2xl mb-4">Grouping Visualization</h2>
            <GChart 
              :settings="{ packages: ['sankey'] }"
              type="Sankey"
              :data="card_sort.sankey_data"
            />
          </div>
        </div>

      </div>
    </main>

    <transition name="modal-component">
      <NewMergeGroupModal
      v-show="new_merge_group_modal_open"
      @close="new_merge_group_modal_open = false"
      @dataChange="update_card_sort_data"
      @clearSelectedGroups="clearSelectedGroups"
      :show="new_merge_group_modal_open"
      :groups="selected_groups"
      :card_sort_id="card_sort.id"
      />
    </transition>

    <transition name="modal-component">
      <ManageMergedGroupModal
      v-show="manage_merged_group_modal_open"
      @close="manage_merged_group_modal_open = false"
      @dataChange="update_card_sort_data"
      :show="manage_merged_group_modal_open"
      :current_name="merged_group_name"
      :group_id="merged_group_id"
      :groups="merged_groups"
      :card_sort_id="card_sort.id"
      />
    </transition>    

  </div>
</template>

<script>
import Rails from '@rails/ujs'
import Chart from 'chart.js'
import { GChart } from 'vue-google-charts'
import Nav from '../components/tree_test_report/nav.vue'
import Sidebar from '../components/tree_test_report/sidebar.vue'
import CardResult from '../components/card_sort_report/card_result.vue'
import GroupResult from '../components/card_sort_report/group_result.vue'
import NewMergeGroupModal from '../components/card_sort_report/new_merge_group_modal.vue'
import ManageMergedGroupModal from '../components/card_sort_report/manage_merged_group_modal.vue'
import Participant from '../components/card_sort_report/participant.vue'

export default {
  props: {
    data: {
      type: Object
    }
  },  
  data () {
    return {
      card_sort: this.data,
      tab: 'cards',
      new_merge_group_modal_open: false,
      manage_merged_group_modal_open: false,
      selected_groups: [],
      merged_group_name: null,
      merged_group_id: null,
      merged_groups: [],
      current_participant_id: this.data.participants[0][0],
      current_participant_database_id: this.data.participants[0][1]
    }
  },
  mounted: function() {
    this.draw_chart()
  },
  methods: {
    draw_chart(){
      var ctx = document.getElementById('bar-chart')
      var myBarChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: this.card_sort.distribution_of_groups_created_per_participant.map(x => x[0] + ((x[0] === 1) ? ' group' : ' groups')),
          datasets: [{
            data: this.card_sort.distribution_of_groups_created_per_participant.map(x => x[1]),
            label: 'abc',
            backgroundColor: '#3F65C8'
          }]
        },
        options: {
          legend: {
            display: false
          },
          tooltips: {
            callbacks: {
              label: function(tooltipItem) {
                return tooltipItem.yLabel;
              }
            }
          },
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true,
                stepSize: 1
              },
              scaleLabel: {
                display: true, 
                labelString: 'Number of participants'
              }
            }]
          }
        }
      });
    },
    manageMergedGroup(id, name, merged_groups) {
      this.merged_group_name = name
      this.merged_group_id = id
      this.merged_groups = merged_groups
      this.manage_merged_group_modal_open = true
    },
    toggleSelectedGroup(group_id, group_name) {
      var index = this.selected_groups.findIndex(group => group[0] === group_id)
      if(index === -1) {
        this.selected_groups.push([group_id, group_name])
      } else {
        this.selected_groups.splice(index, 1)
      }
    },
    clearSelectedGroups() {
      this.selected_groups = []
    },
    update_card_sort_data() {
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort.id,
        type: 'GET',
        success: (arg) => {
          this.card_sort = arg
          this.current_participant_id = this.card_sort.participants[0][0],
          this.current_participant_database_id = this.card_sort.participants[0][1]
          this.draw_chart()
        }
      })
    }
  },
  components: { GChart, Nav, Sidebar, CardResult, GroupResult, NewMergeGroupModal, ManageMergedGroupModal, Participant}
}  
</script>