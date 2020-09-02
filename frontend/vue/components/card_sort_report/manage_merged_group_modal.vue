<template>
  <div class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
    <transition name="overlay">
      <div v-show="show" class="fixed inset-0 transition-opacity">
        <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
      </div>
    </transition>

    <transition name="modal">
      <div v-show="show" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-5xl sm:w-full max-h-full overflow-y-auto">
        <div class="flex items-center justify-between flex-wrap sm:flex-no-wrap border-b border-gray-200 px-4 py-5 sm:px-6">
          <h2 class="text-lg leading-6 font-medium text-gray-900">Merge Groups</h2>
          <button @click="$emit('close')" type="button" class="text-gray-400 hover:text-gray-500 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150">
            <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>          
        </div>
        <div class="px-4 py-5 sm:p-6">
          <label for="name" class="block text-sm font-medium leading-5 text-gray-700">Name</label>
          <div class="mt-1 mb-4 relative rounded-md shadow-sm">
            <input id="name" v-model="name" class="form-input block w-full sm:text-sm sm:leading-5" placeholder="Create a name for this merged group..." />
          </div>
          <div class="flex flex-col">
            <label for="name" class="block text-sm font-medium leading-5 text-gray-700">Merge these groups:</label>
            <div v-for="group in groups" :key="group.id" class="flex items-center">
              <input :id="group.id" :value="group" v-model="selected_groups" type="checkbox" checked class="form-checkbox h-4 w-4 text-purple-600 transition duration-150 ease-in-out" />
              <label :for="group.id" class="ml-2 block text-sm leading-5 text-gray-900">
                  {{ group.name }}
              </label>
            </div>
          </div>
        </div>
        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <span class="mt-3 sm:ml-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
            <button @click="manage" type="button" class="inline-flex justify-center w-full rounded-md border border-transparent px-4 py-2 text-base leading-6 font-medium rounded-md text-white shadow-sm bg-purple-600 hover:bg-purple-500 focus:outline-none focus:shadow-outline transition duration-150 ease-in-out sm:text-sm sm:leading-5">
                Save Changes
            </button>
          </span>
          <span class="mt-3 sm:ml-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
            <button @click="unmerge" type="button" class="inline-flex items-center justify-center w-full px-4 py-2 border border-transparent font-medium rounded-md text-red-700 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150 sm:text-sm sm:leading-5">
                Unmerge This Group
            </button>
          </span>
        </div>       
      </div>
    </transition>
  </div>
</template>

<script>
import Rails from '@rails/ujs'

export default {
  props: {
    show: Boolean,
    groups: Array,
    current_name: String,
    group_id: Number,
    card_sort_id: Number
  },
  data () {
    return {
      selected_groups: this.groups,
      name: this.current_name
    }
  },
  watch: {
    show: function (val) {
      if(val === true) {
        this.selected_groups = this.groups
        this.name = this.current_name
      }
    }
  },  
  methods: {
    unmerge() {
      var data = new FormData
      data.append('id', this.group_id)
      Rails.ajax({
        url: '/unmerge_groups',
        type: 'POST',
        data: data,
        success: (arg) => {
          this.$emit('dataChange')
          this.$emit('close')
        }
      })
    },
    manage() {
      var data = new FormData
      data.append('id', this.group_id)
      data.append('name', this.name)
      this.selected_groups.forEach((group) => {
        data.append('group_ids[]', group.id)
      })
      Rails.ajax({
        url: '/update_merged_group',
        type: 'POST',
        data: data,
        success: (arg) => {
          this.$emit('dataChange')
          this.$emit('close')
        }
      })
    }    
  }
}
</script>