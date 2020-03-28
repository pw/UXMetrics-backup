<template>
  <div>
    <Nav title="New Tree Test" :step.sync="step" :total_steps="total_steps" @save="save"/>

    <Step v-show="step == 1" current_step="1" :total_steps="total_steps" instructions="Let's start with the basics. Then we'll create your tree and tasks.">
      <form>
        <div class="grid grid-cols-1 row-gap-6 col-gap-4 sm:grid-cols-6">
            <TextInput id="name" label="Name" placeholder="Add a descriptive name for your tree test..." v-model="name"/>
            <div class="sm:col-span-4">
              <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
                  Logo
              </label>
              <div class="mt-2 flex items-center">
                <span class="rounded-md shadow-sm">
                  <button type="button" class="py-2 px-3 border border-gray-300 rounded-md text-sm leading-4 font-medium text-gray-700 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-50 active:text-gray-800 transition duration-150 ease-in-out">
                      Choose File
                  </button>
                </span>
              </div>
              <p class="mt-2 text-sm text-gray-500">Upload a custom logo for this tree test</p>
            </div>
            <TextArea id="instructions" label="Participant Instructions" instructions="Greet your tree test participants with a custom introduction" v-model="participant_instructions" />
            <TextArea id="thanks" label="Thank You Message" instructions="Custom thank you message to show participants upon completion" v-model="thank_you_message" />
        </div>
      </form>
    </Step>

    <Step v-show="step == 2" current_step="2" :total_steps="total_steps" instructions="Now let's set up your tree.">
      <div class="mb-6 flex items-center">
        <Slider v-model="randomizeTreeOrder" label="Randomize tree order for participants"/>
      </div>
      <vue-nestable v-model="tree">
        <vue-nestable-handle
          slot-scope="{ item }"
          :item="item">
          <TreeNode @remove="remove" @add="add" :item="item" v-model="item.text" :tree="tree" :placeholder_text="item.placeholder_text"/>
        </vue-nestable-handle>
      </vue-nestable> 
    </Step>
   
    <Step v-show="step == 3" current_step="3" :total_steps="total_steps" instructions="Finally, let's define the tasks you want participants to complete.">      
      <div class="mb-3 flex items-center">
        <Slider v-model="randomizeTaskOrder" label="Randomize task order for participants"/>
      </div>
      <div class="mb-6 flex items-center">
        <Slider v-model="allowSkip" label="Allow participants to skip tasks if they get stuck"/>
      </div>
      <Task v-for="(task, index) in tasks" :key="task.id" :id="task.id" :index="index" :tree="tree" v-model="task.instructions" :correctChoice="task.correctChoice" @removeTask="removeTask" @saveCorrectChoice="saveCorrectChoice" />
      <span class="shadow-sm rounded-md">
        <button @click="addTask" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
          <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
          </svg>
          Add Task
        </button>
      </span>   
   </Step>

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
import Rails from '@rails/ujs'

export default {
  data () {
    return {
      step: 1,
      total_steps: 3,
      name: undefined, 
      participant_instructions: "Thank you for agreeing to help us, it shouldn't take more than 5 minutes!\n\nDon't worry, there is no right or wrong answer, just do what makes sense to you.",
      thank_you_message: "Thanks for taking the time to help us.\n\nYour contribution is essential in our journey to deliver improvements.",
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
      ],    
    }
  },
  methods: {
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
    },
    removeTask(index) {
      this.tasks.splice(index, 1)  
    },
    saveCorrectChoice(task_id, correctChoice) {
      var index = this.tasks.findIndex(i => i.id == task_id)
      this.tasks[index].correctChoice = correctChoice
    }, 
    save() {
      var data = new FormData
      data.append('tree_test[name]', this.name)
      data.append('tree_test[participant_instructions]', this.participant_instructions)
      data.append('tree_test[thank_you_message]', this.thank_you_message)
      data.append('tree_test[randomize_tree_order]', this.randomizeTreeOrder)
      data.append('tree_test[randomize_task_order]', this.randomizeTaskOrder)
      data.append('tree_test[allow_skip]', this.allowSkip)
      data.append('tree_test[tree]', JSON.stringify(this.tree))
      this.tasks.forEach((task, index) => {
        data.append('tree_test[tree_test_tasks_attributes][' + index + '][instructions]', task.instructions) 
        data.append('tree_test[tree_test_tasks_attributes][' + index + '][correct_choice]', JSON.stringify(task.correctChoice))       
      })

      Rails.ajax({
        url: '/tree_tests',
        type: 'POST', 
        data: data,
        dataType: 'json'
      })
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, TreeNode, Task }
}
</script>
<style scoped>
  ol, ul {
    padding-left: 20px;
  }
  .nestable {
    position: relative;
  }
  .nestable-rtl {
    direction: rtl;
  }
  .nestable .nestable-list {
    margin: 0;
    padding: 0 0 0 40px;
    list-style-type: none;
  }
  .nestable-rtl .nestable-list {
    padding: 0 40px 0 0;
  }
  .nestable > .nestable-list {
    padding: 0;
  }
  .nestable-item,
  .nestable-item-copy {
    margin: 10px 0 0;
  }
  .nestable-item:first-child,
  .nestable-item-copy:first-child {
    margin-top: 0;
  }
  .nestable-item .nestable-list,
  .nestable-item-copy .nestable-list {
    margin-top: 10px;
  }
  .nestable-item {
    position: relative;
  }
  .nestable-item.is-dragging .nestable-list {
    pointer-events: none;
  }
  .nestable-item.is-dragging * {
    opacity: 0;
    filter: alpha(opacity=0);
  }
  .nestable-item.is-dragging:before {
    content: ' ';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(106, 127, 233, 0.274);
    border: 1px dashed rgb(73, 100, 241);
    -webkit-border-radius: 5px;
    border-radius: 5px;
  }
  .nestable-drag-layer {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 100;
    pointer-events: none;
  }
  .nestable-rtl .nestable-drag-layer {
    left: auto;
    right: 0;
  }
  .nestable-drag-layer > .nestable-list {
    position: absolute;
    top: 0;
    left: 0;
    padding: 0;
    background-color: rgba(106, 127, 233, 0.274);
  }
  .nestable-rtl .nestable-drag-layer > .nestable-list {
    padding: 0;
  }
  .nestable [draggable="true"] {
    cursor: move;
  }
</style>