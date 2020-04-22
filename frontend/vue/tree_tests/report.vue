<template>
  <div>
    <Nav :name="tree_test.name" :created_at="tree_test.created_at_day" :id="tree_test.id" />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap items-end mb-16">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 self-center">
            <div class="py-4 bg-white rounded shadow px-4 my-4">
              <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.test_results_count }}</p>
              <h4 @click="modal_open = true" class="-mt-2 font-semibold px-2 text-center text-gray-500">Results</h4>
            </div>
            <div class="py-4 bg-white rounded shadow px-4 my-4">
              <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.percent_success }}%</p>
              <h4 class="-mt-2 font-semibold px-2 text-center text-gray-500">Average success score</h4>
            </div>
            <div class="py-4 bg-white rounded shadow px-4 my-4">
              <p class="font-semibold px-2 text-center text-4xl text-indigo-600">{{ tree_test.median_time }}</p>
              <h4 class="-mt-2 font-semibold px-2 text-center text-gray-500">Median time to complete</h4>              
            </div>
          </div>
          <div class="w-full md:w-2/3 xl:w-3/5 self-center">
            <h2 class="text-2xl mb-4">
                Aggregate Score Breakdown (All Tasks)
            </h2> 
            <div class="w-full mb-6 h-10">
              <div class="h-10 bg-green-500" :style="{ width: tree_test.percent_navigated_directly_to_correct + '%'}" style="width: %; display: inline-block; float: left;"></div>
              <div class="h-10 bg-green-300" :style="{ width: tree_test.percent_navigated_indirectly_to_correct + '%'}" style="display: inline-block; float: left;"></div>   
              <div class="h-10 bg-red-500" :style="{ width: tree_test.percent_navigated_directly_to_incorrect + '%'}" style="display: inline-block; float: left;"></div>   
              <div class="h-10 bg-red-300" :style="{ width: tree_test.percent_navigated_indirectly_to_incorrect + '%'}" style="display: inline-block; float: left;"></div>             
              <div class="h-10 bg-gray-500" :style="{ width: tree_test.percent_skipped_directly + '%'}" style="display: inline-block; float: left;"></div>
              <div class="h-10 bg-gray-300" :style="{ width: tree_test.percent_skipped_indirectly + '%'}" style="display: inline-block; float: left;"></div>              
            </div>              
            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-green-500">
                    <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_directly_to_correct }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                    Participants navigated directly to correct links {{ tree_test.percent_navigated_directly_to_correct }}% of the time.
                </p>
              </div>
            </div>    
            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-green-300">
                  <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_indirectly_to_correct }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                      Participants navigated indirectly to correct links {{ tree_test.percent_navigated_indirectly_to_correct }}% of the time.
                </p>
              </div>
            </div> 
            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-red-500">
                  <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_directly_to_incorrect }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                      Participants navigated directly to incorrect links {{ tree_test.percent_navigated_directly_to_incorrect }}% of the time.
                </p>
              </div>
            </div>          
            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-red-300">
                  <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_navigated_indirectly_to_incorrect }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                    Participants navigated indirectly to incorrect links {{ tree_test.percent_navigated_indirectly_to_incorrect }}% of the time.
                </p>
              </div>
            </div>

            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-500">
                  <span class="text-md font-medium leading-none text-white">{{ tree_test.percent_skipped_directly }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                    Participants directly skipped tasks {{ tree_test.percent_skipped_directly }}% of the time.
                </p>
              </div>
            </div>

            <div class="flex mb-4">
              <div class="flex-initial mr-2">
                <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-300">
                  <span class="text-md font-medium leading-none text-gray-500">{{ tree_test.percent_skipped_indirectly }}%</span>
                </span>
              </div>
              <div class="flex self-center">
                <p class="text-md leading-5 text-gray-500">
                        Participants indirectly skipped tasks {{ tree_test.percent_skipped_indirectly }}% of the time.
                </p>
              </div>  
            </div>          

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
            <div v-show="tab == 'tasks'">
              <Task
              v-for="(task, index) in tasks"
              :key="task.id"
              :task="task"
              :index="index"
              @openTaskOutcomeModal="openTaskOutcomeModal"
              />
            </div>

          </div>         
        </div>

      </div>
    </main>

    <TaskOutcomeDetailsModal 
    v-show="modal_open"
    @close="modal_open = false"
    :task="tasks[modal_task_index]"
    :task_index="modal_task_index"
    :outcome="modal_outcome"
    :outcome_summary="task_outcome_summary"
    />

  </div>
</template>

<script>
import Rails from '@rails/ujs'
import Nav from '../components/tree_test_report/nav.vue'
import Task from '../components/tree_test_report/task.vue'
import TaskOutcomeDetailsModal from '../components/tree_test_report/task_outcome_details_modal.vue'
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
      modal_open: false,
      modal_task_index: 0,
      modal_outcome: 'indirect_correct',
      task_outcome_summary: []
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
          this.modal_open = true          
        }
      })
    }
  },
  components: { Nav, Task, TaskOutcomeDetailsModal }
}  
</script>