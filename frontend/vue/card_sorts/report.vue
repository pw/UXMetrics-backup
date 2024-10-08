<template>
  <div>
    <Nav 
    :name="card_sort.name" 
    :created_at="card_sort.created_at_day" 
    :id="card_sort.id" 
    test_type="card_sorts"
    :show_back="!shared_report"
    />
    
    <ReportBanner
      :report_private="card_sort.report_private"
      :password_protect_report="card_sort.password_protect_report"
      :report_url="card_sort.shared_report_url"
      :edit_url="card_sort.edit_url + '?tab=Pro'"
      :shared_report="shared_report"
    />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end">
          <div class="w-full mb-6">
            <Sidebar :test="card_sort" middle_box_description="Unique groups created" :middle_box_value="card_sort.group_results.length" />
          </div>
        </div>

        <div class="flex flex-wrap">
          <div class="w-full mb-6"> 
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
              <div v-show="!shared_report" class="md:flex md:items-center md:justify-between mb-4">
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
                      :show_merge_checkboxes="!shared_report"
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
                  v-for="(participant, index) in card_sort.participants" 
                  :key="participant[1]" 
                  class="flex-shrink-0 px-3 py-2 font-medium text-sm leading-5 rounded-md cursor-pointer" 
                  :class="{ 'text-purple-700 bg-purple-100 focus:outline-none focus:text-purple-800 focus:bg-purple-200': (current_participant_index === index), 'text-gray-500 hover:text-gray-700 focus:outline-none focus:text-purple-600 focus:bg-purple-50': (current_participant_index !== index)}"
                  aria-current="page"
                  @click="current_participant_index = index"
                  >
                      Participant {{ participant[0] }}
                  </a>                    
                </nav>               
              </div>  
              <Participant
                :card_sort="card_sort"
                :participant_index="current_participant_index"
                :editable="!shared_report"
                @participantDeleted="participantDeleted"
                @participantIncludedOrExcluded="update_card_sort_data"
              />             
            </div>            
          </div>         
        </div>

        <div class="flex flex-wrap">
          <div class="w-full">
            <GChart 
              :settings="{ packages: ['sankey'] }"
              type="Sankey"
              :data="card_sort.sankey_data"
            />
          </div>
        </div>
        <!-- <div class="flex flex-wrap">
          <h2 @click="draw_chart" class="text-2xl mb-4">Groups Created</h2>
          <canvas id="bar-chart"></canvas>
        </div> -->

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
import ReportBanner from '../components/report_banner.vue'

export default {
  props: {
    data: Object,
    shared_report: {
      type: Boolean,
      default: false
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
      current_participant_index: 0
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
      if(this.shared_report) {
        return
      }
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
    participantDeleted() {
      if(this.current_participant_index !== 0) {
        this.current_participant_index -= 1
      }
      this.update_card_sort_data()
    },
    update_card_sort_data() {
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort.id,
        type: 'GET',
        success: (arg) => {
          this.card_sort = arg
          this.draw_chart()
        }
      })
    }
  },
  components: { GChart, Nav, Sidebar, CardResult, GroupResult, NewMergeGroupModal, ManageMergedGroupModal, Participant, ReportBanner }
}  
</script>