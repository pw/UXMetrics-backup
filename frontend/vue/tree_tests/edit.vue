<template>
  <div>
    <Nav :name="tree_test.name" :created_at="tree_test.created_at_day" :status="tree_test.status" />

    <main class="py-6">   
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap">

          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">

            <div v-show="tree_test.status == 'draft'" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 class="text-lg leading-6 font-medium text-gray-900">
                  Your tree test has been created!
                </h3>

                <p class="text-sm text-center py-2 mb-4">Ready to publish? Just hit the button below.</p>

                <button @click="publish" class="block w-full text-center px-6 py-3 rounded-md shadow-sm cursor-pointer border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
                  Publish
                </button>
              </div>
            </div>

            <div v-show="tree_test.status == 'published' && tree_test.test_results_count == 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <p class="text-sm text-center py-2">
                  We'll email when you get your first result.
                </p>
              </div>
            </div>     

            <div v-show="tree_test.status == 'published' && tree_test.test_results_count != 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 v-if="tree_test.test_results_count == 1" class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  1 Test Result
                </h3>
                <h3 v-else class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  {{ tree_test.test_results_count }} Test Results
                </h3>                
                <div class="fields-inline items-end">
                  <a class="block w-full text-center px-6 py-3 rounded-md shadow-sm border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150" :href="'/tree_tests/' + tree_test.id + '/report'">
                    View Report
                  </a>                
                </div>
              </div>
            </div>

            <div v-show="tree_test.status == 'published'" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 class="text-lg leading-6 font-medium text-gray-900">
                  Your tree test is <span class="text-green-500">published</span>.
                </h3>

                <p class="text-sm text-center py-2 mb-4">
                  Copy the link below to share with participants.
                </p>

                <div>
                  <div class="mt-1 flex rounded-md shadow-sm">
                    <div class="relative flex-grow focus-within:z-10">
                      <input id="email" class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" :value="tree_test.collect_url" />
                    </div>
                    <button v-clipboard:copy="tree_test.collect_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
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

            <div class="bg-gray-200 overflow-hidden rounded-lg mb-6 text-center">
              <div class="px-4 py-5 sm:p-6">
                <a @click="endTest" v-show="tree_test.status == 'published'" class="end-t mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md shadow-sm text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150 cursor-pointer">End This Test</a>   

                <p v-show="tree_test.status == 'ended'" class="mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-gray-200">This test has been ended.</p>                       
                <p class="text-sm">
                  Need to <a @click="deleteTest" class="text-red-700 underline cursor-pointer">delete</a> this study?
                </p>
              </div>
            </div>
          </div>  

          <div class="w-full md:w-2/3 xl:w-3/5">
            <div class="shadow sm:rounded-md sm:overflow-hidden">
              <div class="px-4 py-5 bg-white sm:p-6">
                <div class="bg-purple-50 sm:rounded-lg mb-6">
                  <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                      Participant Preview
                    </h3>
                    <div class="mt-2 sm:flex sm:items-start sm:justify-between">
                      <div class="max-w-xl text-sm leading-5 text-gray-500">
                        <p>
                          Test drive your study exactly as your participants will experience it.
                        </p>
                      </div>
                      <div class="mt-5 sm:mt-0 sm:ml-6 sm:flex-shrink-0 sm:flex sm:items-center">
                        <span class="shadow-sm rounded-md">
                          <a :href="tree_test.collect_url + '?preview=true'" target="_blank" class="preview-btn inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                            <svg class="-ml-1 mr-2 h-5 w-5 text-gray-700" fill="currentColor" viewBox="0 0 20 20">
                              <path d="M10 12C11.1046 12 12 11.1046 12 10C12 8.89543 11.1046 8 10 8C8.89544 8 8.00001 8.89543 8.00001 10C8.00001 11.1046 8.89544 12 10 12Z"/>
                              <path fill-rule="evenodd" clip-rule="evenodd" d="M0.457764 10C1.73202 5.94291 5.52232 3 9.99997 3C14.4776 3 18.2679 5.94288 19.5422 9.99996C18.2679 14.0571 14.4776 17 9.99995 17C5.52232 17 1.73204 14.0571 0.457764 10ZM14 10C14 12.2091 12.2091 14 10 14C7.79087 14 6.00001 12.2091 6.00001 10C6.00001 7.79086 7.79087 6 10 6C12.2091 6 14 7.79086 14 10Z"/>
                            </svg>
                            Preview
                          </a>
                        </span>
                      </div>
                    </div>
                  </div>
                </div>

                <div>
                  <div class="mb-6">
                    <div class="block">
                      <div class="border-b border-gray-200 text-gray-500">
                        <nav class="-mb-px flex">
                          <button 
                            @click="tab = 'settings'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'settings' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Settings
                          </button>
                          <button 
                            @click="tab = 'tree'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'tree' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Tree
                          </button>
                          <button 
                            @click="tab = 'tasks'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'tasks' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Tasks
                          </button>
                        </nav>
                      </div>
                    </div>
                  </div>              
                </div>

                <div v-show="tab == 'settings'">
                  <form>
                    <div class="mb-6 pb-6 border-b border-gray-100">
                      <TextInput id="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your tree test..." v-model="tree_test.name" @blur="saveProperty('name')" :disabled="tree_test.status != 'draft'" />
                    </div>
                    <div class="mb-6 pb-6 border-b border-gray-100">
                      <div class="sm:col-span-4">
                        <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
                            Logo
                        </label>
                        <p class="mb-2 text-sm text-gray-500">Add your branding to this study (optional)</p>
                        <img v-show="tree_test.logo_key !== undefined" :src="tree_test.logo_base_url + '/' + tree_test.logo_key" class="w-40">
                        <div class="mt-2 flex items-center">
                          <span class="rounded-md shadow-sm">
                            <button @click="openUpload" type="button" class="py-2 px-3 border border-gray-300 rounded-md text-sm leading-4 font-medium text-gray-700 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-50 active:text-gray-800 transition duration-150 ease-in-out">
                                Choose File
                            </button>
                          </span>
                        </div>
                      </div>
                    </div>
                    <div class="mb-6 pb-6 border-b border-gray-100">
                      <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with a custom introduction" :disabled="tree_test.status != 'draft'" v-model="tree_test.participant_instructions" @blur="saveProperty('participant_instructions')" />
                    </div>
                    <div class="">
                      <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" :disabled="tree_test.status != 'draft'" v-model="tree_test.thank_you_message" @blur="saveProperty('thank_you_message')"/>
                    </div>
                  </form>              
                </div>

                <div v-show="tab == 'tree'">
                  <vue-nestable v-model="tree" :hooks="{ 'beforeMove': beforeMove}" @change="saveTree">
                    <vue-nestable-handle
                      slot-scope="{ item }"
                      :item="item">
                      <TreeNode @remove="remove" @add="add" @blur="saveTree" :item="item" v-model="item.text" :tree="tree" :placeholder_text="item.placeholder_text" :disabled="tree_test.status != 'draft'" />
                    </vue-nestable-handle>
                  </vue-nestable>              
                </div>

                <div v-show="tab == 'tasks'">
                  <div class="mb-6 pb-6 border-b border-gray-100">
                    <Task 
                    v-for="(task, index) in tree_test.tree_test_tasks" 
                    :key="task.id" 
                    :id="task.id" 
                    :index="index" 
                    :tree="tree" 
                    v-model="task.instructions" 
                    :correctChoice="task.tree_test_task_correct_choices" 
                    :disabled="tree_test.status != 'draft'" 
                    @removeTask="removeTask" 
                    @saveCorrectChoice="saveCorrectChoice" 
                    @saveTask="saveTask" 
                    />
                    <span class="shadow-sm rounded-md" v-show="tree_test.status == 'draft'">
                      <button @click="addTask" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                        <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                          <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
                        </svg>
                        Add Task
                      </button>
                    </span>
                  </div>
                  <div class="mb-6 pb-6 border-b border-gray-100">
                    <Slider v-model="tree_test.randomize_task_order" @input="saveProperty('randomize_task_order')" :disabled="tree_test.status != 'draft'" label="Randomize task order for participants" description="This ensures that each task has a chance to be presented earlier in the session"/>
                  </div>
                  <div class="">
                    <Slider v-model="tree_test.allow_skip" @input="saveProperty('allow_skip')" :disabled="tree_test.status != 'draft'" label="Allow participants to skip tasks if they get stuck" description="This can reduce abandonment rates and skips are tracked for you"/>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div> 
    </main>

    <transition name="modal-component">
      <Subscribe
      v-show="subscribe_modal_open"
      @close="subscribe_modal_open = false"
      :show="subscribe_modal_open"
      />
    </transition>    
  </div>
</template>

<script>
import Nav from '../components/edit_tree_test/nav.vue'
import Subscribe from '../components/subscribe.vue'
import Rails from '@rails/ujs'

import TextInput from '../components/new_tree_test/text_input.vue'
import TextArea from '../components/new_tree_test/text_area.vue'
import Slider from '../components/slider.vue'
import TreeNode from '../components/new_tree_test/tree_node.vue'
import Task from '../components/new_tree_test/task.vue'
import * as filestack from 'filestack-js'
const filestack_client = filestack.init('AuALnf2VzTPqJAkEOLar1z');

export default {
  props: {
    data: {
      type: Array
    }
  },
  data () {
    return {
      tree_test: this.data[0],
      tree: JSON.parse(this.data[0].tree),
      tab: 'settings',
      subscribe_modal_open: false   
    }
  },  
  computed: {
    tasks_index: function() {
      var task_indices = this.data[0].tree_test_tasks.map(task => task.task_number)
      return (Math.max(...task_indices) + 1)
    }
  },
  methods: {
    publish() {
      var r = confirm('Are you sure?')
      if(r == true) {
        var data = new FormData 
        data.append('tree_test[status]', 'published')
        Rails.ajax({
          url: '/tree_tests/' + this.tree_test.id,
          type: 'PATCH', 
          data: data,
          success: () => {
            this.tree_test.status = 'published'
          } 
        })        
      }
    },
    deleteTest() {
      var r = confirm('Are you sure?')
      if(r == true) {
        Rails.ajax({
          url: '/tree_tests/' + this.tree_test.id,
          type: 'DELETE'
        })
      }
    },
    endTest() {
      var r = confirm('Are you sure?')
      if(r == true) {
        var data = new FormData 
        data.append('tree_test[status]', 'ended')
        Rails.ajax({
          url: '/tree_tests/' + this.tree_test.id,
          type: 'PATCH', 
          data: data,
          success: () => {
            this.tree_test.status = 'ended'
          }
        })        
      }      
    }, 
    openUpload() {
      if(this.tree_test.status !== 'draft') {
        return 
      }
      const options = {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*'],
        onUploadDone: (arg) => {
          this.tree_test.logo_key = arg.filesUploaded[0].key
          this.saveProperty('logo_key')
        }
      }
      filestack_client.picker(options).open()
    },    
    saveProperty(property) {
      var data = new FormData 
      data.append('tree_test[' + property + ']', this.tree_test[property])
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data
      }) 
    },
    saveTree() {
      var data = new FormData 
      data.append('tree_test[tree]', JSON.stringify(this.tree))
      data.append('tree_test[current_tree_index]', this.tree_test.current_tree_index)      
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data
      }) 
    },    
    saveTask(id) {
      var index = this.tree_test.tree_test_tasks.findIndex(i => i.id == id)
      var data = new FormData 
      data.append('tree_test[tree_test_tasks_attributes][0][id]', id)
      data.append('tree_test[tree_test_tasks_attributes][0][instructions]', this.tree_test.tree_test_tasks[index].instructions)
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data
      })      
    },
    add(id) {
      this.tree_test.current_tree_index += 1
      this.addToArray(this.tree, id)
      this.saveTree()
    },
    remove(id) {
      this.removeFromArray(this.tree, id)
      this.saveTree()
    },
    addToArray(array, id) {
      var index = array.findIndex(i => i.id == id)
      if(index != -1)
        this.addChild(array[index])
      else 
        array.forEach((element) => {
          if(element.children !== undefined)
            this.addToArray(element.children, id)
        })
    },
    addChild(node) {
      node.children.push({id: this.tree_test.current_tree_index, children: []})
    },
    removeFromArray(array, id) {
      var index = array.findIndex(i => i.id == id)
      if(index != -1)
        array.splice(index, 1)
      else 
        array.forEach((element) => {
          if(element.children !== undefined)
            this.removeFromArray(element.children, id)
        })
    },
    addTask() {      
      var data = new FormData 
      data.append('tree_test_task[tree_test_id]', this.tree_test.id)       
      data.append('tree_test_task[task_number]', this.tasks_index)       
      var tree_test = this.tree_test 
      Rails.ajax({
        url: '/tree_test_tasks',
        type: 'POST', 
        data: data,
        success: function(data){
          tree_test.tree_test_tasks.push(data)
        }
      })     
    },
    removeTask(index) {
      var task = this.tree_test.tree_test_tasks.splice(index, 1)[0]
      var data = new FormData 
      data.append('tree_test[tree_test_tasks_attributes][0][id]', task.id)
      data.append('tree_test[tree_test_tasks_attributes][0][_destroy]', 1)
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data
      })           
    },
    saveCorrectChoice(task_id, correctChoice) {
      var index = this.tree_test.tree_test_tasks.findIndex(i => i.id == task_id)
      this.tree_test.tree_test_tasks[index].correctChoice = correctChoice
      this.saveCorrectChoiceToServer(task_id, correctChoice)
    },
    saveCorrectChoiceToServer(task_id, correctChoice){
      var data = new FormData 
      data.append('tree_test_task[id]', task_id)
      correctChoice.forEach((choice, choice_index)  => {
        data.append('tree_test_task[tree_test_task_correct_choices_attributes][' + choice_index + '][node]', choice.node)
        data.append('tree_test_task[tree_test_task_correct_choices_attributes][' + choice_index + '][path]', choice.path)
      })
      
      Rails.ajax({
        url: '/tree_test_tasks/' + task_id,
        type: 'PATCH', 
        data: data
      })
    },
    beforeMove(dragItem, pathFrom, pathTo) {
      if(this.tree_test.status == 'draft') {
        return true
      } else {
      return false
      }
    } 
  },
  components: { Nav, Subscribe, TextInput, TextArea, Slider, TreeNode, Task }
}
</script>