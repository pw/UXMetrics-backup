<template>
  <div>
    <Nav 
    :name="tree_test.name" 
    :created_at="tree_test.created_at_day" 
    :id="tree_test.id" 
    test_type="tree_tests"
    :show_back="!shared_report" 
    />

    <ReportBanner
      :report_private="tree_test.report_private"
      :password_protect_report="tree_test.password_protect_report"
      :report_url="tree_test.shared_report_url"
      :edit_url="tree_test.edit_url + '?tab=Pro'"
      :shared_report="shared_report"
    />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end mb-8">
          <div class="w-full">
            <Sidebar :test="tree_test" middle_box_description="Average success score" :middle_box_value="tree_test.percent_success + '%'" />
          </div>
        </div>
        <div class="flex flex-wrap">
          <div class="w-full mb-16"> 
            <div class="w-full">
              <Chart :tree_test="tree_test" />
            </div>
          </div>
        </div>

        <div class="flex flex-wrap">
          <div class="w-full mb-16">

            <div class="mb-6">
              <div class="block">
                <div class="border-b border-gray-200 text-gray-500">
                  <nav class="-mb-px flex">
                    <button 
                      @click="tab = 'tasks'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'tasks' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Tasks
                    </button>
                    <button 
                      @click="tab = 'participants'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab === 'participants' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Individual Results
                    </button>
                  </nav>
                </div>
              </div>
            </div>  

            <div v-show="tab === 'tasks'">
              <Task
              v-for="(task, index) in tree_test.tree_test_tasks"
              :key="task.id"
              :task="task"
              :index="index"
              @openTaskOutcomeModal="openTaskOutcomeModal"
              />
            </div>

            <div v-show="tab === 'participants'">
              <Participants 
              :tasks="tasks"
              :participants="participants"
              :total_participants="total_participants"
              :tree_test_id="tree_test.id"
              @open="openParticipantModal"
              :editable="!shared_report"
              />        
            </div>

          </div>         
        </div>

      </div>
    </main>
    
    <transition name="modal-component">
      <TaskOutcomeDetailsModal 
      v-show="task_modal_open"
      @close="task_modal_open = false"
      :show="task_modal_open"
      :task="tasks[modal_task_index]"
      :task_index="modal_task_index"
      :outcome="modal_outcome"
      :outcome_summary="task_outcome_summary"
      />
    </transition>

    <transition name="modal-component">
      <ParticipantDetails
      v-show="participant_modal_open"
      @close="participant_modal_open = false"
      :show="participant_modal_open"
      :participant="participant"
      :participant_index="participant_index"
      />
    </transition>

  </div>
</template>

<script>
import Rails from '@rails/ujs'
import Nav from '../components/tree_test_report/nav.vue'
import Sidebar from '../components/tree_test_report/sidebar.vue'
import Chart from '../components/tree_test_report/score_breakdown_chart.vue'
import Participants from '../components/tree_test_report/participants.vue'
import Task from '../components/tree_test_report/task.vue'
import TaskOutcomeDetailsModal from '../components/tree_test_report/task_outcome_details_modal.vue'
import ParticipantDetails from '../components/tree_test_report/participant_details_modal.vue'
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
      tree_test: this.data,
      tab: 'tasks',     
      task_modal_open: false,
      modal_task_index: 0,
      modal_outcome: 'indirect_correct',
      task_outcome_summary: [],
      participants: this.data.participants,
      total_participants: this.data.total_participants,
      participant_modal_open: false,
      participant: this.data.participants[0],
      participant_index: 1
    }
  },
  created: function() {
    this.tasks = this.tree_test.tree_test_tasks.sort((a, b) => a.task_number - b.task_number)
  },
  methods: {
    openTaskOutcomeModal(task_id, outcome) {
      Rails.ajax({
        url: '/tree_test_tasks/' + task_id + '/outcome?outcome=' + outcome,
        type: 'GET',
        success: (response) => {
          this.task_outcome_summary = response
          this.modal_outcome = outcome
          this.modal_task_index = this.tasks.findIndex((i) => i.id == task_id)
          this.task_modal_open = true          
        }
      })
    },
    openParticipantModal(participant, index) {
      this.participant = participant
      this.participant_index = index + 1
      this.participant_modal_open = true
    }
  },
  components: { Nav, Sidebar, Chart, Task,  TaskOutcomeDetailsModal, Participants, ParticipantDetails, ReportBanner }
}  
</script>