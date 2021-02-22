<template>
  <div class="px-2 mb-4" :class="{ undraggable: cards.length === 0 }">
    <div class="bg-gray-200 overflow-hidden rounded-md shadow">
      <div v-if="cards.length === 0 && value === undefined">Drag a card here to create a new group</div>
      <div v-else class="handle bg-white px-4 py-2 border-b border-gray-200" :class="{ 'cursor-move': draggable }">
        <div v-show="editing_name" class="-ml-4 -mt-2 flex items-center justify-between flex-wrap">
          <div class="flex-1 ml-4 mt-2">
            <div class="rounded-md shadow-sm">
              <input class="form-input px-2 py-1 block w-full transition duration-150 ease-in-out text-base font-medium leading-5 text-gray-700" ref="name" :value="value" @input="$emit('input', $event.target.value)" @keyup.enter="saveGroupName" placeholder="Group Name" />
            </div>
          </div>
          <div class="ml-2 mt-2 flex-shrink-0">
            <span class="inline-flex rounded-md shadow-sm">
              <button @click="saveGroupName" type="button" class="undraggable inline-flex items-center px-2 py-1 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                <svg class="-ml-1 mr-2 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM13.7071 8.70711C14.0976 8.31658 14.0976 7.68342 13.7071 7.29289C13.3166 6.90237 12.6834 6.90237 12.2929 7.29289L9 10.5858L7.70711 9.29289C7.31658 8.90237 6.68342 8.90237 6.29289 9.29289C5.90237 9.68342 5.90237 10.3166 6.29289 10.7071L8.29289 12.7071C8.68342 13.0976 9.31658 13.0976 9.70711 12.7071L13.7071 8.70711Z"/>
                </svg>
                Save
              </button>
            </span>
          </div>
        </div>        
        <div v-show="!editing_name" class="-ml-4 -mt-2 flex items-center justify-between flex-wrap">
          <div class="ml-4 mt-2">
            <a @click="toggleNameEdit" class="undraggable text-base font-medium leading-5  cursor-pointer" :class="{'underline text-purple-600': can_edit_name}">
                {{ computedName }} 
            </a>
          </div>
          <div v-show="can_delete" class="ml-4 mt-2 flex-shrink-0">
            <span class="inline-flex rounded-md shadow-sm">
              <button @click="$emit('deleteGroup', id)" type="button" class="undraggable inline-flex items-center px-2 py-1 border border-transparent text-xs leading-4 font-medium rounded text-red-500 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
                <svg class="h-5 w-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M9 2C8.62123 2 8.27497 2.214 8.10557 2.55279L7.38197 4H4C3.44772 4 3 4.44772 3 5C3 5.55228 3.44772 6 4 6L4 16C4 17.1046 4.89543 18 6 18H14C15.1046 18 16 17.1046 16 16V6C16.5523 6 17 5.55228 17 5C17 4.44772 16.5523 4 16 4H12.618L11.8944 2.55279C11.725 2.214 11.3788 2 11 2H9ZM7 8C7 7.44772 7.44772 7 8 7C8.55228 7 9 7.44772 9 8V14C9 14.5523 8.55228 15 8 15C7.44772 15 7 14.5523 7 14V8ZM12 7C11.4477 7 11 7.44772 11 8V14C11 14.5523 11.4477 15 12 15C12.5523 15 13 14.5523 13 14V8C13 7.44772 12.5523 7 12 7Z"/>
                </svg>
              </button>
            </span>
          </div>
        </div>
      </div>
      
      <draggable 
      v-model="cards"
      :id="`group_${index}`"         
      group="cards"
      class="p-4 undraggable"      
      style="min-height: 6rem;"  
      ghost-class="card-draggable-ghost-class"
      @add="cardMove"
      @update="cardMove"
      >            
        <Card 
        v-for="card in cards"
        :id="card.id"
        :key="card.id"
        :title="card.title"
        :description="card.description"
        :show_description="false"        
        />
      </draggable>
    </div>  
  </div> 
</template>

<script>
  import draggable from 'vuedraggable'
  import Card from '../card.vue'
  export default {
    props: {
      id: String,
      index: Number,
      draggable: Boolean,
      can_edit_name: Boolean,
      can_delete: Boolean,
      value: String,
      initial_cards: Array
    },
    data () {
      return {
        cards: this.initial_cards,
        editing_name: false
      }
    },
    computed: {
      computedName: function(){
        if(this.value === undefined){
          return 'Name this group...'
        } else {
          return this.value          
        }
      }
    },
    watch: {
      cards: function(val) {
        this.$emit('updateCards', this.id, val)
      }
    },
    methods: {
      cardMove(event) {
        this.$emit('cardMove', event)
      },
      saveGroupName() {
        this.editing_name = false
        var event = { group: `group_${this.group_column_index}_${this.index}`, name: this.value }        
        this.$emit('saveGroupName', event)
      },
      toggleNameEdit() {
        if(this.can_edit_name) {
          this.editing_name = true
          this.$nextTick(function() {
            this.$refs.name.focus()
          })
        }
      },
    },
    components: { Card, draggable }
  }
</script>