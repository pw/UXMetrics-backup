<template>
  <div class="sm:col-span-4">
    <div class="mb-6 pb-6 border-b border-gray-100">
      <label class="mb-2 block text-sm leading-5 font-medium text-gray-700">
        Pre-Defined Groups
      </label>
      <Draggable
        v-if="enabled"
        v-model="groups"
        ghost-class="group-list-ghost-class"
        @change="saveGroups"
        filter=".form-input"
        :prevent-on-filter="false"
      >
        <Group 
        v-for="group in groups"
        v-model="group.name" 
        ref="group_refs"
        :key="group.id"
        :group_id="group.id" 
        @remove="removeGroup" 
        @nextGroup="nextGroup" 
        @updateGroup="updateGroup" 
        />
      </Draggable>
      <Group
        v-else
        v-for="group in groups"
        :key="group.id"
        v-model="group.name"
        :group_id="group.id"
        :disabled="true"
      />
      <span class="shadow-sm rounded-md">
        <button v-show="enabled" @click="addGroup" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
          <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
          </svg>
            New Group
        </button>
      </span>
    </div>  
  </div>  
</template>

<script>
import Rails from '@rails/ujs'  
import Draggable from 'vuedraggable'  
import Group from './group.vue'

export default {
  components: { Group, Draggable },
  props: {
    value: Array,
    card_sort_id: Number,
    enabled: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      groups: this.value
    }
  },
  methods: {
    saveGroups() {
      if(!this.enabled) { return }
      var data = new FormData
      this.groups.forEach((group, index) => {
        data.append('card_sort[card_sort_groups_attributes][' + index + '][id]', group.id) 
        data.append('card_sort[card_sort_groups_attributes][' + index + '][order]', index)       
      })    
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort_id,
        type: 'PATCH', 
        data: data
      })              
    },
    removeGroup(id) {
      if(!this.enabled) { return }
      var index = this.groups.findIndex(i => i.id == id)
      var data = new FormData
      data.append('card_sort_group[card_sort_id]', this.card_sort_id)
      Rails.ajax({
        url: '/card_sort_groups/' + id,
        type: 'DELETE',
        data: data,
        success:  (arg) => {
          this.groups.splice(index, 1)
        }
      })              
    },  
    nextGroup: function(group_id) {
      var index = this.groups.findIndex(i => i.id == group_id)
      if(index === this.groups.length - 1) {
        this.addGroup()       
      } else {
        this.$nextTick(function() {
          this.$refs.group_refs[index + 1].$refs.input.focus()
        })          
      }
    },  
    addGroup: function() {
      if(!this.enabled) { return }
      var index = this.groups.length
      var data = new FormData
      data.append('card_sort_group[order]', index)
      data.append('card_sort_group[card_sort_id]', this.card_sort_id)
      Rails.ajax({
        url: '/card_sort_groups',
        type: 'POST', 
        data: data,
        success:  (arg) => {
          this.groups.push(arg)
          this.$nextTick(function() {
            this.$refs.group_refs[this.groups.length - 1].$refs.input.focus()
          })          
        }
      })      
    }, 
    updateGroup(id) {
      if(!this.enabled) { return }
      var index = this.groups.findIndex(i => i.id == id)
      var data = new FormData
      data.append('card_sort_group[name]', this.groups[index].name)     
      Rails.ajax({
        url: '/card_sort_groups/' + id,
        type: 'PATCH', 
        data: data
      })              
    },               
  }
}
</script>