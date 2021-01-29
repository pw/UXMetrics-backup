<template>
  <div class="mb-6 pb-6 border-b border-gray-100">
    <Task 
      v-for="(task, index) in value" 
      :key="task.id" 
      :id="task.id"
      :index="index"  
      :tree="tree"
      :disabled="disabled" 
      v-model="task.instructions" 
      @saveTask="saveTask"
      :correctChoice="task.tree_test_task_correct_choices" 
      @removeTask="removeTask" 
      @saveCorrectChoice="saveCorrectChoice" />
    <span v-show="!disabled" class="shadow-sm rounded-md">
      <button @click="addTask" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
        <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
          <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
        </svg>
        Add Task
      </button>
    </span>
  </div>	
</template>

<script>
import Rails from '@rails/ujs'
import Task from './task.vue'

export default {
  components: { Task },
  props: {
    value: Array,
    tree_test_id: Number,
    json_tree: String,
    disabled: {
      type: Boolean, 
      default: false
    }
  },
  data() {
    return {
    }
  },
  computed: {
    tree: function() {
      return JSON.parse(this.json_tree)
    },
    tasks_index: function() {
      var task_indices = this.value.map(task => task.order)
      return (Math.max(...task_indices) + 1)
    }    
  },  
  methods: {
    addTask() {
      var data = new FormData 
      data.append('tree_test_task[tree_test_id]', this.tree_test_id)       
      data.append('tree_test_task[order]', this.tasks_index)       
      Rails.ajax({
        url: '/tree_test_tasks',
        type: 'POST', 
        data: data,
        success: (response) => {
          var tasks = this.value 
          tasks.push(response)
          this.change(tasks)
        }
      })       
    },
    removeTask(id) {   
      if(this.value.length === 1) {
        return 
      }   
      var index = this.tasks.findIndex(i => i.id === id)
      Rails.ajax({
        url: '/tree_test_tasks/' + id,
        type: 'DELETE',
        success: (arg) => {
          var tasks = this.value
          tasks.splice(index, 1)
          this.change(tasks)
        }
      })
    },
    saveTask(task_id) {
      var index = this.value.findIndex(i => i.id === task_id)
      var data = new FormData 
      data.append('tree_test_task[id]', task_id)
      data.append('tree_test_task[instructions]', this.value[index].instructions)
      Rails.ajax({
        url: '/tree_test_tasks/' + task_id,
        type: 'PATCH', 
        data: data
      })          
    },    
    saveTasks(id) {
      var data = new FormData 
      this.value.forEach((task, task_index) => {
        data.append(`tree_test[tree_test_tasks_attributes][${task_index}][id]`, task.id)
        data.append(`tree_test[tree_test_tasks_attributes][${task_index}][instructions]`, task.instructions)
        data.append(`tree_test[tree_test_tasks_attributes][${task_index}][order]`, task_index)
      })
      Rails.ajax({
        url: `/tree_tests/${this.tree_test.id}`,
        type: 'PATCH', 
        data: data
      })       
    },
    saveCorrectChoice(task_id, correctChoice) {
      var index = this.value.findIndex(i => i.id === task_id)
      var data = new FormData
      data.append('tree_test_task[id]', task_id)
      correctChoice.forEach((choice, choice_index)  => {
        data.append('tree_test_task[tree_test_task_correct_choices_attributes][' + choice_index + '][node]', choice.node)
        data.append('tree_test_task[tree_test_task_correct_choices_attributes][' + choice_index + '][path]', choice.path)
      })
      Rails.ajax({
        url: '/tree_test_tasks/' + task_id,
        type: 'PATCH', 
        data: data,
        success: (response) => {
          var tasks = this.value
          tasks[index].tree_test_task_correct_choices = correctChoice
          this.change(tasks)
        }
      })      
    },    
    change(tasks) {
      this.$emit('input', tasks)
    }    
  }
}
</script>