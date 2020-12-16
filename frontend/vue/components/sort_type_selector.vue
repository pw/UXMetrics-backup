<template>
  <div class="sm:col-span-4">
    <label for="sort_type" class="mb-2 block text-sm leading-5 font-medium text-gray-700">
        Sort Type
    </label>
    <div
    @click="changeSortType('open')"
    v-show="enabled || (sort_type === 'open')" 
    :class="{'bg-purple-100  border border-purple-600': (sort_type === 'open'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'open'), 'cursor-pointer hover:bg-purple-200': enabled}" 
    class="overflow-hidden shadow rounded-lg  mb-3 transition duration-150 ease-in-out">
      <div class="p-2 sm:p-3">
        <div class="flex items-center">
          <div class="flex-shrink-0 p-1">
            <input 
              v-model="sort_type"  
              value="open"
              :disabled="!enabled" 
              id="open_sort" 
              name="sort_type" 
              aria-label="open" 
              type="radio"
              class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
          </div>
          <div class="ml-2 w-0 flex-1">
            <p class="text-sm leading-5 font-medium text-gray-700">Open</p>
            <p class="text-sm text-gray-500">Participants sort cards into groups they create and name</p>
          </div>
        </div>
      </div>
    </div>
    <div 
    @click="changeSortType('closed')"
    v-show="enabled || (sort_type === 'closed')" 
    :class="{'bg-purple-100 border border-purple-600': (sort_type === 'closed'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'closed'), 'cursor-pointer hover:bg-purple-200': enabled}" class="overflow-hidden shadow rounded-lg mb-3 transition duration-150 ease-in-out">
      <div class="p-2 sm:p-3">
        <div class="flex items-center">
          <div class="flex-shrink-0 p-1">
            <input 
            v-model="sort_type" 
            value="closed"
            :disabled="!enabled" 
            id="closed_sort" 
            name="sort_type" 
            aria-label="closed" 
            type="radio" 
            class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
          </div>
          <div class="ml-2 w-0 flex-1">
            <p class="text-sm leading-5 font-medium text-gray-700">Closed</p>
            <p class="text-sm text-gray-500">Participants sort cards into groups pre-defined by you</p>
          </div>
        </div>
      </div>
    </div>
    <div 
    @click="changeSortType('hybrid')"
    v-show="enabled || (sort_type === 'hybrid')" 
    :class="{'bg-purple-100 border border-purple-600': (sort_type === 'hybrid'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'hybrid'), 'cursor-pointer hover:bg-purple-200': enabled}" class="overflow-hidden shadow rounded-lg mb-3 transition duration-150 ease-in-out">
      <div class="p-2 sm:p-3">
        <div class="flex items-center">
          <div class="flex-shrink-0 p-1">
            <input 
              v-model="sort_type"
              value="hybrid" 
              :disabled="!enabled" 
              id="hybrid_sort" 
              name="sort_type"
              aria-label="hybrid" 
              type="radio" 
              class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
          </div>
          <div class="ml-2 w-0 flex-1">
            <p class="text-sm leading-5 font-medium text-gray-700">Hybrid</p>
            <p class="text-sm text-gray-500">Participants sort cards into into pre-defined groups but can also create and name their own groups</p>
          </div>
        </div>
      </div>
    </div>
  </div> 
</template>

<script>
export default {
  props: {
    value: String, 
    enabled: Boolean
  },
  data() {
    return {
      sort_type: this.value
    }
  },
  methods: {
    changeSortType(sort_type) {
      this.sort_type = sort_type
      this.$emit('input', sort_type)
    }
  }
}
</script>