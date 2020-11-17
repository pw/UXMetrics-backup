<template>
  <div>
    <Nav :title="title" :step.sync="step" :total_steps="total_steps" @back="back"/>
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
      <ul class="space-y-4 md:flex md:space-y-0 md:space-x-8">
        <li class="md:flex-1">
          <!-- Completed Step -->
          <div class="group pl-4 py-2 block border-l-4 border-purple-600 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-purple-600 font-semibold uppercase">Step 1</h3>
            <p class="text-sm leading-5 font-medium">Study Setup</p>
          </div>
        </li>

        <li class="md:flex-1">
          <!-- Upcoming Step -->
          <div 
          class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4"
          :class="{'border-purple-600': (step >= 2)}"
          >
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 2</h3>
            <p class="text-sm leading-5 font-medium">Add Tree</p>
          </div>
        </li>

        <li class="md:flex-1">
          <!-- Upcoming Step -->
          <div 
          class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4"
          :class="{'border-purple-600': (step >= 3)}"
          >
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 3</h3>
            <p class="text-sm leading-5 font-medium">Create Tasks</p>
          </div>
        </li>

        <li class="md:flex-1">
          <!-- Upcoming Step -->
          <div class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 4</h3>
            <p class="text-sm leading-5 font-medium">Preview and Publish</p>
          </div>
        </li>
      </ul>
    </nav>
    <Step v-show="step == 1" current_step="1" :total_steps="total_steps" instructions="Let's start with the basics. Then we'll create your tree and tasks.">
      <form>
        <div class="shadow sm:rounded-md sm:overflow-hidden">
          <div class="px-4 py-5 bg-white sm:p-6">
            <div class="mb-6 pb-6 border-b border-gray-100">
              <TextInput id="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your study..." v-model="name"/>
            </div>
            <div class="mb-6 pb-6 border-b border-gray-100">
              <div class="sm:col-span-4">
                <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
                    Logo
                </label>
                <p class="mb-2 text-sm text-gray-500">Add your branding to this study (optional)</p>
                <img v-show="logo_key !== undefined" :src="logo_base_url + '/' + logo_key" class="mb-6 w-40">
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
              <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with an introduction" v-model="participant_instructions" />
            </div>
            <div class="">
              <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" v-model="thank_you_message" />
            </div>
          </div>
          <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
            <span class="inline-flex rounded-md shadow-sm">
              <button type="button" @click="next" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
                Save and Continue
              </button>
            </span>
          </div>  
        </div>
      </form>
    </Step>

    <Step v-show="step == 2" current_step="2" :total_steps="total_steps" instructions="Now let's set up a tree representing your information architecture.">
      <div class="shadow sm:rounded-md sm:overflow-hidden">
        <div class="px-4 py-5 bg-white sm:p-6">
          <vue-nestable :hooks="{'beforeMove': beforeMove}" v-model="tree">
            <vue-nestable-handle
              slot-scope="{ item }"
              :item="item">
              <TreeNode @remove="remove" @add="add" :item="item" v-model="item.text" :tree="tree" :placeholder_text="item.placeholder_text"/>
            </vue-nestable-handle>
          </vue-nestable>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <span class="inline-flex rounded-md shadow-sm">
            <button type="button" @click="next" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
              Save and Continue
            </button>
          </span>
        </div> 
      </div>
    </Step>
   
    <Step v-show="step == 3" current_step="3" :total_steps="total_steps" instructions="Finally, let's define the tasks you want participants to complete, and set the correct choice(s) for each.">      
      <div class="shadow sm:rounded-md sm:overflow-hidden">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="mb-6 pb-6 border-b border-gray-100">
            <Task v-for="(task, index) in tasks" :key="task.id" :id="task.id" :index="index" :tree="tree" v-model="task.instructions" :correctChoice="task.correctChoice" @removeTask="removeTask" @saveCorrectChoice="saveCorrectChoice" />
            <span class="shadow-sm rounded-md">
              <button @click="addTask" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
                </svg>
                Add Task
              </button>
            </span>
          </div>
          <div class="mb-6 pb-6 border-b border-gray-100">
            <Slider v-model="randomizeTaskOrder" label="Randomize task order for participants" description="This ensures that each task has a chance to be presented earlier in the session" />
          </div>
          <div class="">
            <Slider v-model="allowSkip" label="Allow participants to skip tasks if they get stuck" description="This can reduce abandonment rates and skips are tracked for you" />
          </div>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <span class="inline-flex rounded-md shadow-sm">
            <button type="button" @click="save" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
              Save and Continue
            </button>
          </span>
        </div> 
      </div>
    </Step>
    <Flash v-show="show_flash" :show="show_flash" :notice="flash_notice">
    </Flash>
  </div>
</template>

<script>
import Nav from '../components/new_tree_test/nav.vue'
import Step from '../components/new_tree_test/step.vue'
import TextInput from '../components/new_tree_test/text_input.vue'
import TextArea from '../components/new_tree_test/text_area.vue'
import Slider from '../components/slider.vue'
import TreeNode from '../components/new_tree_test/tree_node.vue'
import Task from '../components/new_tree_test/task.vue'
import Flash from '../components/flash.vue'
import Rails from '@rails/ujs'
import * as filestack from 'filestack-js'
const filestack_client = filestack.init('AuALnf2VzTPqJAkEOLar1z');

export default {
  props: {
    data: Object
  },  
  data () {
    return {
      step: 1,
      total_steps: 3,
      show_flash: false, 
      flash_notice: '',
      name: '', 
      logo_base_url: this.data.logo_base_url,
      logo_key: undefined,
      filestack_options: {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*']        
      },
      participant_instructions: "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Just do what makes sense to you.",
      thank_you_message: "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements.",
      randomizeTreeOrder: false,
      allowSkip: false,
      randomizeTaskOrder: false,
      tasks_index: 2,
      tasks: [
        {
          id: 1,
          instructions: 'Task instructions (e.g. "Imagine that you want to update your credit card details. Where would you find that?")',
          correctChoice: []
        }
      ],
      node_index: 3,
      tree: [
        {
          id: 0,
          text: 'Home',
          placeholder_text: 'Home',
          children: [{
            id: 1,
            text: 'Child',
            placeholder_text: 'Child',
            children: [{
              id: 2,
              text: 'Child of Child',
              placeholder_text: 'Child of Child',
              children: []
            }]
          }]
        }
      ]  
    }
  },
  methods: {
    next: function() {
      if(this.step === 1 && this.name === '') {
        this.flash_notice = 'Name cannot be blank'
        this.showFlash()
      } else {
        this.step += 1
      }
    },
    back: function() {
      this.step -= 1
    },
    showFlash: function() {
      this.show_flash = true
      setTimeout(() => this.show_flash = false, 5000)
    },    
    add: function(id) {
      this.node_index += 1
      this.addToArray(this.tree, id)
    },
    remove: function(id) {
      this.removeFromArray(this.tree, id)
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
      node.children.push({id: this.node_index, children: []})
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
      this.tasks.push({id: this.tasks_index, instructions: 'Task instructions (e.g. "Imagine that you want to update your credit card details. Where would you find that?")', correctChoice: []})
      this.tasks_index += 1
    },
    removeTask(index) {
      this.tasks.splice(index, 1)  
    },
    saveCorrectChoice(task_id, correctChoice) {
      var index = this.tasks.findIndex(i => i.id == task_id)
      this.tasks[index].correctChoice = correctChoice
    },
    openUpload() {
      const options = {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*'],
        onUploadDone: (arg) => {
          this.logo_key = arg.filesUploaded[0].key
        }
      }
      filestack_client.picker(options).open()
    },     
    save() {
      var data = new FormData
      data.append('tree_test[name]', this.name)
      data.append('tree_test[logo_key]', this.logo_key)
      data.append('tree_test[participant_instructions]', this.participant_instructions)
      data.append('tree_test[thank_you_message]', this.thank_you_message)
      data.append('tree_test[randomize_tree_order]', this.randomizeTreeOrder)
      data.append('tree_test[randomize_task_order]', this.randomizeTaskOrder)
      data.append('tree_test[allow_skip]', this.allowSkip)
      data.append('tree_test[tree]', JSON.stringify(this.tree))
      data.append('tree_test[current_tree_index]', this.node_index)
      this.tasks.forEach((task, index) => {
        data.append('tree_test[tree_test_tasks_attributes][' + index + '][instructions]', task.instructions) 
        data.append('tree_test[tree_test_tasks_attributes][' + index + '][task_number]', task.id)        
        task.correctChoice.forEach((choice, choice_index) => {
          data.append('tree_test[tree_test_tasks_attributes][' + index + '][tree_test_task_correct_choices_attributes][' + choice_index + '][node]', choice.node)
          data.append('tree_test[tree_test_tasks_attributes][' + index + '][tree_test_task_correct_choices_attributes][' + choice_index + '][path]', choice.path)
        })     
      })

      Rails.ajax({
        url: '/tree_tests',
        type: 'POST', 
        data: data,
        dataType: 'json'
      })
    },
    beforeMove({dragItem, pathFrom, pathTo}) {
      if(pathTo.length == 1) {
        return false
      } else {
        return true
      }
    }
  },
  computed: {
    title: function() {
      if(this.step == 1) {
        return 'New Tree Test'
      } else {
        return this.name
      }
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, TreeNode, Task, Flash }
}
</script>