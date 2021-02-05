<template> 
  <div class="min-h-screen bg-gray-100">
    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-white rounded-lg shadow mb-6">
          <div class="px-4 py-5 sm:p-6">
            <div v-show="step == 'intro'">
              <img :src="tree_test.logo_url" class="mb-6 w-40">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Welcome!
              </h3> 
              <div class="max-w-xl text-md leading-5 text-gray-700"> {{ tree_test.participant_instructions }}
              </div>              
              <div class="mt-5">
                <span class="shadow-sm rounded-md cursor-pointer">
                  <a @click="next" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                    Continue
                    <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                    </svg>
                  </a>
                </span>
              </div>    
            </div>   
            <div v-show="step == 'instructions'" >
              <img :src="tree_test.logo_url" class="mb-6 w-40">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-6">
                Instructions
              </h3>     
              <div class="grid grid-cols-1 col-gap-4 row-gap-8 md:grid-cols-2 text-gray-700">
                <div class="sm:col-span-1">
                  <div class="mb-6">
                    <ul>
                      <li>
                        <div class="flex items-center mb-6">
                          <div class="min-w-0 flex-1 flex items-center">
                            <div class="flex-shrink-0">
                              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-400">
                                <span class="text-lg font-medium leading-none text-white">1</span>
                              </span>
                            </div>
                            <div class="min-w-0 flex-1 px-4">
                              We are going to show you a list of links along with some tasks.
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="flex items-center mb-6">
                          <div class="min-w-0 flex-1 flex items-center">
                            <div class="flex-shrink-0">
                              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-400">
                                <span class="text-lg font-medium leading-none text-white">2</span>
                              </span>
                            </div>
                            <div class="min-w-0 flex-1 px-4">
                              For each task, click or tap through the links until you find the one you would expect to help you complete that task.
                            </div>
                          </div>
                        </div>
                      </li>
                      <li>
                        <div class="flex items-center mb-6">
                          <div class="min-w-0 flex-1 flex items-center">
                            <div class="flex-shrink-0">
                              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-gray-400">
                                <span class="text-lg font-medium leading-none text-white">3</span>
                              </span>
                            </div>
                            <div class="min-w-0 flex-1 px-4">
                              If you get lost just click the link again, or click any of the links above. There are no right or wrong answers, just choose what makes the most sense to you!
                            </div>
                          </div>
                        </div>
                      </li>
                    </ul>
                  </div>
                </div>
                <div class="sm:col-span-1">
                  <div class="bg-gray-200 overflow-hidden rounded-lg text-center h-full">
                    <div class="px-4 py-5 sm:p-6">
                      <img :src="treetest_gif_url">
                    </div>
                  </div>
                </div>
              </div>
              <div class="mt-5">
                <span class="shadow-sm rounded-md cursor-pointer">
                  <a @click="next" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                    Get Started
                    <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                    </svg>
                  </a>
                </span>
              </div>               
            </div> 
            <div v-show="step == 'tasks'">
              <h3 class="text-xl leading-6 font-medium text-gray-900">
                Task {{ current_task_index + 1 }} of {{ tasks.length }}
              </h3>   
              <div class="max-w-xl text-md leading-5 text-gray-500">
                <p>{{ tasks[current_task_index].instructions }}</p>
                <svg class="mt-4 h-12 w-12 text-gray-500 lookhere" fill="currentColor" viewBox="0 0 24 24" stroke="none">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M14.7071 12.2929C15.0976 12.6834 15.0976 13.3166 14.7071 13.7071L10.7071 17.7071C10.3166 18.0976 9.68342 18.0976 9.29289 17.7071L5.29289 13.7071C4.90237 13.3166 4.90237 12.6834 5.29289 12.2929C5.68342 11.9024 6.31658 11.9024 6.70711 12.2929L9 14.5858L9 3C9 2.44772 9.44772 2 10 2C10.5523 2 11 2.44772 11 3L11 14.5858L13.2929 12.2929C13.6834 11.9024 14.3166 11.9024 14.7071 12.2929Z" fill="#4A5568"/>
                </svg>
              </div>                         
            </div>    
            <div v-show="step == 'thanks'">
              <img :src="tree_test.logo_url" class="w-1/5 mb-6">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Thank you!
              </h3>
              <div class="max-w-xl text-md leading-5 text-gray-500">
                <p>{{ tree_test.thank_you_message }}</p>
              </div>              
            </div>         
          </div>
        </div>
        <div v-show="step == 'tasks'" class="mt-6 md:w-1/2">
          <MenuNode 
          @setChoice="setChoice" 
          @setLastPath="setLastPath"
          @addToNavigationHistory="addToNavigationHistory" 
          @markAsIndirect="markAsIndirect"
          :element="tree[0]" 
          :randomizeTreeOrder="tree_test.randomize_tree_order" 
          :margin="0" 
          :collapsed="false"
          :key="menu_node_key"
          :is_root="true"
          />
        </div>
        <div v-show="tree_test.allow_skip" class="mt-12 text-center">
          <a v-show="step == 'tasks'" @click="skipTask" class="text-sm text-gray-500 underline cursor-pointer">
            Skip This Task
          </a>
        </div>        
      </div>
    </main>
  </div>
</template>

<script>
  import Rails from '@rails/ujs'
  import MenuNode from '../components/tree_test_participants/collapsible_menu_node.vue'
  var _ = require('lodash');
  export default {
    props: {
      data: Object,
      preview: Boolean,
      treetest_gif_url: String
    },
    components: { MenuNode },
    data() {
      return {
        tree_test: this.data,
        tasks: undefined,
        tree: JSON.parse(this.data.tree),
        step: 'intro',
        current_task_index: 0,
        results: [],
        current_task_start: undefined,
        current_task_id: undefined,
        task_skipped: false,
        choice: undefined,
        openChildMenuItem: -1,
        last_path: [JSON.parse(this.data.tree)[0].text],
        navigation_history: [JSON.parse(this.data.tree)[0].text],
        menu_node_key: 0,
        direct: true
      }
    },
    created: function() {
      if(this.tree_test.randomize_task_order) {
        this.tasks = _.shuffle(this.data.tree_test_tasks)
      } else {
        this.tasks = this.data.tree_test_tasks
      }
    },
    methods: {
      next() {
        switch(this.step) {
          case 'intro':
            this.step = 'instructions'
            break
          case 'instructions':
            this.step = 'tasks'
            this.startTask()
            break
          case 'tasks':
            this.nextTask()
            break
        }
      },
      setChoice(id) {
        this.choice = id
        this.next()
      },
      setLastPath(lineage) {
        this.last_path = lineage
      },
      addToNavigationHistory(node_name) {
        this.navigation_history.push(node_name)
      },
      markAsIndirect(){
        this.direct = false
      },
      skipTask() {
        this.task_skipped = true
        if(this.navigation_history.length != 1) {
          this.direct = false
        }
        this.next()
      },
      nextTask() {
        this.endTask()
        if(this.current_task_index === (this.tasks.length - 1)) {
          this.step = 'thanks'
          this.saveResults()
        } else {
          this.current_task_index += 1
          this.menu_node_key += 1
          this.startTask()
        }        
      },
      startTask() {
        this.current_task_start = new Date
        this.current_task_id = this.tasks[this.current_task_index].id
        this.choice = -1
        this.task_skipped = false
        this.direct = true
        this.navigation_history = [this.tree[0].text]

      },
      endTask() {
        var endTime = new Date
        var timeElapsed = (endTime - this.current_task_start)
        var result = {
          elapsed_time: timeElapsed,
          choice: this.choice,
          task_id: this.current_task_id,
          skip: this.task_skipped,
          path: this.navigation_history,
          direct: this.direct
        }
        this.results.push(result)
      },
      saveResults() {
        if(!this.preview) {
          var data = new FormData
          data.append('tree_test_participant[tree_test_id]', this.tree_test.id)
          this.results.forEach((result, index) => {
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][tree_test_task_id]', result.task_id)
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][time]', result.elapsed_time)          
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][choice]', result.choice)
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][skip]', result.skip)
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][path]', result.path)   
            data.append('tree_test_participant[tree_test_participant_results_attributes][' + index + '][direct]', result.direct)                 
          })
          Rails.ajax({
            url: '/tree_test_participants',
            type: 'POST', 
            data: data,
          })
        }
      }
    }
  }
</script>