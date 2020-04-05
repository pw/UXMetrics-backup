<template>
  <div class="bg-white overflow-hidden shadow rounded-lg mb-6">
    <div class="border-b border-gray-200 px-2 py-3 sm:px-4">
      <div class="flex items-center justify-between">
        <span>Task {{ index + 1 }}</span>
        <span v-show="!disabled" class="inline-flex rounded-md shadow-sm">
          <button @click="$emit('removeTask', index)" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-red-700 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
            -
          </button>
        </span>
      </div>
    </div>
    <div class="px-4 py-5 sm:p-6">
      <div class="flex rounded-md shadow-sm mb-3">
        <textarea rows="3" class="form-textarea block w-full h-20 transition duration-150 ease-in-out sm:text-sm sm:leading-5" :class="{ 'opacity-50 cursor-not-allowed': disabled}"  :value="value" @input="$emit('input', $event.target.value)" @blur="$emit('saveTask', id)">
        </textarea>
      </div>
      <div :class="{flex: (!treeVisible && correctSelected), 'items-center': (!treeVisible && correctSelected), 'justify-between': (!treeVisible && correctSelected)}">

        <span class="inline-flex rounded-md shadow-sm mr-2" v-show="!treeVisible && correctSelected && !disabled" @click="treeVisible = true">
          <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150">
            Change
          </button>
        </span>        

        <div class="flex" v-show="(treeVisible) || (!correctSelected && !treeVisible)">         
          <span class="inline-flex rounded-md shadow-sm" v-show="!correctSelected && !treeVisible && !disabled">
            <button @click="treeVisible = true" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150">
              Set Correct Choice(s)
            </button>
          </span>
          <span class="inline-flex rounded-md shadow-sm" v-show="treeVisible">
            <a @click="saveCorrectChoice" class="cursor-pointer inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
              <svg class="-ml-1 mr-2 h-4 w-4 text-white" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM13.7071 8.70711C14.0976 8.31658 14.0976 7.68342 13.7071 7.29289C13.3166 6.90237 12.6834 6.90237 12.2929 7.29289L9 10.5858L7.70711 9.29289C7.31658 8.90237 6.68342 8.90237 6.29289 9.29289C5.90237 9.68342 5.90237 10.3166 6.29289 10.7071L8.29289 12.7071C8.68342 13.0976 9.31658 13.0976 9.70711 12.7071L13.7071 8.70711Z"/>
              </svg>
              Save
            </a>
          </span>
          <span class="inline-flex rounded-md shadow-sm ml-2" v-show="treeVisible">
            <button @click="treeVisible = false" type="button" class="inline-flex items-center px-2.5 py-1.5 border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
              Cancel
            </button>
          </span>
        </div>

        <div v-show="!treeVisible && correctSelected" class="flex flex-wrap">        
          <div 
          class="flex items-center justify-between w-full bg-gray-100 overflow-x-auto rounded-md h-8 px-2 py-1" 
          v-for="choice in correctChoiceLocal"
          >
            <span class="ml-2 block text-sm leading-5 text-gray-700">
              <ul class="flex flex-no-wrap pl-0">
                <li 
                v-for="(heir, index) in choice.path.split(',')"
                :class="{'text-green-500 font-bold': (index == (choice.path.split(',').length - 1))}"
                class="flex-none">
                  {{ heir }}
                  <span v-show="index != (choice.path.split(',').length - 1)" class="mx-2">
                    &rarr;
                  </span>                
                </li>
              </ul>
            </span>
          </div>

        </div>

        <div id="tree" class="mt-6" v-show="treeVisible">
          <ChoiceTreeNode @toggleCorrectChoice="toggleCorrectChoice" v-for="element in tree" :key="id" :element="element" :margin="0" :correct_choice="correctChoiceLocal" />
        </div>

      </div>      
    </div>

  </div>	
</template>

<script>
import ChoiceTreeNode from './choice_tree_node.vue'
export default {
  props: {
    value: String,
    index: Number,
    tree: Array, 
    id: Number, 
    correctChoice: Array,
    disabled: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      treeVisible: false,
      correctChoiceLocal: this.correctChoice
    }
  }, 
  computed: {
    correctSelected: function() {
      if(this.correctChoiceLocal.length == 0) {
        return false
      } else {
        return true
      }
    }
  },
  methods: {
    toggleCorrectChoice(id, lineage, text) {
      var index = this.correctChoiceLocal.findIndex(i => i.node == id)
      if(index == -1) {
        this.correctChoiceLocal.push({node: id, path: lineage.concat([text]).join(',')})
      } else {
        this.correctChoiceLocal.splice(index, 1)
      }
    },
    saveCorrectChoice() {
      this.$emit('saveCorrectChoice', this.id, this.correctChoiceLocal)
      this.treeVisible = false
    }
  },
  components: { ChoiceTreeNode }
}
</script>