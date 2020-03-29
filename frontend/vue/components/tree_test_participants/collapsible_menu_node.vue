<template>
  <div>
    <div class="flex items-center justify-between bg-white overflow-hidden shadow rounded-md h-8 px-2 py-1 mb-2" :class="{'border-2 border-indigo-500': (!collapsedLocal && (element.children.length == 0))}" :style="{'margin-left': margin + 'rem'}">
      <a @click="toggle" class="ml-2 block text-sm leading-5 text-blue-700 underline"> {{ element.text }}
      </a>
      <span v-if="!collapsedLocal && (element.children.length == 0)" class="inline-flex rounded-md shadow-sm">
        <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150" style="margin-right: -10px;">
          <svg class="-ml-1 mr-2 h-3 w-3 text-white" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M9.70711 16.7071C9.31658 17.0976 8.68342 17.0976 8.29289 16.7071L2.29289 10.7071C1.90237 10.3166 1.90237 9.68342 2.29289 9.29289L8.29289 3.29289C8.68342 2.90237 9.31658 2.90237 9.70711 3.29289C10.0976 3.68342 10.0976 4.31658 9.70711 4.70711L5.41421 9H17C17.5523 9 18 9.44772 18 10C18 10.5523 17.5523 11 17 11L5.41421 11L9.70711 15.2929C10.0976 15.6834 10.0976 16.3166 9.70711 16.7071Z"/>
          </svg>  
          I'd Go Here
        </button>
      </span>      
    </div>
      <transition-group name="fade">
        <Node 
          v-show="!collapsedLocal && ((openChildMenuItem == -1) || (openChildMenuItem == child.id))"  
          @toggleChildMenuItem="toggleChildMenuItem" 
          :openSiblingMenuItem="openChildMenuItem" 
          v-for="child in element.children" 
          :element="child" 
          :key="child.id" :parentCollapsed="collapsedLocal" 
          :margin="margin + 1.5" 
        />
      </transition-group>
  </div>
</template>

<script>
  export default {
    props: {
      element: Object,
      margin: Number,
      collapsed: {
        type: Boolean,
        default: true
      },
      openSiblingMenuItem: {
        type: Number,
        default: -1
      },
      parentCollapsed: Boolean
    },
    data() {
      return {
        collapsedLocal: true,
        openChildMenuItem: -1,
      }
    },
    watch: {
      parentCollapsed: function(val) {
        if(val == true) {
          if(this.collapsedLocal == false) {
            this.$emit('toggleChildMenuItem', this.element.id)
          }  
          this.collapsedLocal = true   
        }
      }
    },
    name: 'Node',
    methods: {
      toggleChildMenuItem(id) {
        
        if(this.openChildMenuItem == id) {
          this.openChildMenuItem = -1
        } else {
          this.openChildMenuItem = id
        }        
      },      
      toggle() {
        this.collapsedLocal = !this.collapsedLocal
        this.$emit('toggleChildMenuItem', this.element.id)
      }
    }
  }
</script>