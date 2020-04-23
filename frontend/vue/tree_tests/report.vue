<template>
  <div>
    <Nav :name="tree_test.name" :created_at="tree_test.created_at_day" :id="tree_test.id" />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end mb-16">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 self-center">
            <Sidebar :tree_test="tree_test" />
          </div>
          <div class="w-full md:w-2/3 xl:w-3/5 self-center">
            <Chart :tree_test="tree_test" />
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
                      @click="tab = 'tasks'"
                      :class="{ 'border-indigo-500 text-indigo-600 focus:outline-none focus:text-indigo-800 focus:border-indigo-700': tab == 'tasks' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Tasks
                    </button>
                    <button 
                      @click="tab = 'participants'"
                      :class="{ 'border-indigo-500 text-indigo-600 focus:outline-none focus:text-indigo-800 focus:border-indigo-700': tab === 'participants' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Individual Results
                    </button>
                  </nav>
                </div>
              </div>
            </div>  

            <div v-show="tab === 'tasks'">
              <Task
              v-for="(task, index) in tasks"
              :key="task.id"
              :task="task"
              :index="index"
              @openTaskOutcomeModal="openTaskOutcomeModal"
              />
            </div>

            <div v-show="tab === 'participants'">
              <Participants 
              :task="tasks"
              :participants="participants"
              @open="openParticipantModal"
              />        
            </div>

          </div>         
        </div>

      </div>
    </main>

    <TaskOutcomeDetailsModal 
    v-show="task_modal_open"
    @close="task_modal_open = false"
    :task="tasks[modal_task_index]"
    :task_index="modal_task_index"
    :outcome="modal_outcome"
    :outcome_summary="task_outcome_summary"
    />

    <ParticipantDetails
    v-show="participant_modal_open"
    @close="participant_modal_open = false"
    :participant="participant"
    :participant_index="participant_index"
    />

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
export default {
  props: {
    data: {
      type: Array
    }
  },  
  data () {
    return {
      tree_test: this.data[0],
      tab: 'tasks',
      tasks: undefined,      
      task_modal_open: false,
      modal_task_index: 0,
      modal_outcome: 'indirect_correct',
      task_outcome_summary: [],
      participants: this.data[0].participants,
      participant_modal_open: false,
      participant: this.data[0].participants[0],
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
    openParticipantModal(participant_id, index) {
      this.participant = this.participants[index]
      this.participant_index = index + 1
      this.participant_modal_open = true
    }
  },
  components: { Nav, Sidebar, Chart, Task,  TaskOutcomeDetailsModal, Participants, ParticipantDetails }
}  
</script>