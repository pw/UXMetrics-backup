<template>
  <div>
    <div v-show="step  === 'intro'" class="min-h-screen bg-gray-100">
      <main class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="bg-white sm:rounded-lg mb-6">
            <div class="px-4 py-5 sm:p-6">
              
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Welcome!
              </h3>
              <div class="max-w-xl text-md leading-5 text-gray-500"> {{ card_sort.participant_instructions }}
              </div>
              <div class="mt-5">
                <span class="shadow-sm rounded-md">
                  <a @click="step = 'instructions'" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                    Continue
                    <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                    </svg>
                  </a>
                </span>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
    <div v-show="step === 'instructions'" class="min-h-screen bg-gray-100">
      <main class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="bg-white sm:rounded-lg mb-6">
            <div class="px-4 py-5 sm:p-6">
              <img :src="card_sort.logo_url" class="mb-6">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-6">
                Instructions
              </h3>
              <div class="grid grid-cols-1 col-gap-4 row-gap-8 md:grid-cols-2">
                <div class="sm:col-span-1">
                  <div class="mb-6">
                    <p class="mb-3">
                        We're going to show you some cards at the bottom of the screen. 
                        We'd like you to categorize these cards into groups that make sense to you. You can do this by dragging and dropping them into the area above.
                    </p>
                    <p>
                        There are no right or wrong answers, just do what makes sense to you!
                    </p>
                  </div>
                </div>
                <div class="sm:col-span-1">
                  <div class="bg-gray-200 overflow-hidden rounded-lg text-center h-full">
                    <div class="px-4 py-5 sm:p-6">
                      Demo GIF will go here
                    </div>
                  </div>
                </div>
              </div>
              <div class="mt-5">
                <span class="shadow-sm rounded-md">
                  <a @click="step = 'sort'" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                    Get Started
                    <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                    </svg>
                  </a>
                </span>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>  
    <div v-show="step === 'sort'">
      <div class="bg-white shadow-sm px-4 py-5 sm:px-6">
          <div class="-ml-4 -mt-4 flex justify-between items-center flex-wrap sm:flex-no-wrap">
              <div class="ml-4 mt-4">
                  <span class="shadow-sm rounded-md">
                      <button class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                          <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd" clip-rule="evenodd" d="M18 10C18 14.4183 14.4183 18 10 18C5.58172 18 2 14.4183 2 10C2 5.58172 5.58172 2 10 2C14.4183 2 18 5.58172 18 10ZM11 6C11 6.55228 10.5523 7 10 7C9.44772 7 9 6.55228 9 6C9 5.44772 9.44772 5 10 5C10.5523 5 11 5.44772 11 6ZM9 9C8.44772 9 8 9.44772 8 10C8 10.5523 8.44772 11 9 11V14C9 14.5523 9.44772 15 10 15H11C11.5523 15 12 14.5523 12 14C12 13.4477 11.5523 13 11 13V10C11 9.44772 10.5523 9 10 9H9Z" />
                          </svg>
                          Instructions
                      </button>
                  </span>
              </div>
              <div class="ml-4 mt-4 flex items-center">
                  <span class="invisible sm:visible flex-1 self-center mr-4 text-sm leading-5 font-medium">
                      All done?
                  </span>
                  <span class="shadow-sm rounded-md">
                      <button class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                          <svg class="-ml-1 mr-2 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM13.7071 8.70711C14.0976 8.31658 14.0976 7.68342 13.7071 7.29289C13.3166 6.90237 12.6834 6.90237 12.2929 7.29289L9 10.5858L7.70711 9.29289C7.31658 8.90237 6.68342 8.90237 6.29289 9.29289C5.90237 9.68342 5.90237 10.3166 6.29289 10.7071L8.29289 12.7071C8.68342 13.0976 9.31658 13.0976 9.70711 12.7071L13.7071 8.70711Z"/>
                          </svg>
                          Submit
                      </button>
                  </span>
              </div>
          </div>
      </div>
      <div class="px-6 py-6 mb-64">        
        <draggable 
        id="groups"
        v-model="groups"
        class="flex flex-wrap -mx-2" 
        group="cards"
        swap-threshold="0.65"
        ghost-class="draggable-new-group"
        @updateCards="updateCards"  
        :move="onGroupMove"
        >
          <Group
          v-for="group in groups"
          :key="group.id"
          :id="group.id"   
          :can_delete="group.can_delete"
          :initial_cards="group.cards"
          v-model="group.name"          
          @updateCards="updateCards"
          @addGroup="addGroup"
          @deleteGroup="deleteGroup"
          />
        </draggable>
      </div>
      <div class="fixed inset-x-0 bottom-0 w-full">
        <div class="flex overflow-x-auto bg-gray-200 px-6 pt-6 pb-4 sm:px-6 sm:pt-12 sm:pb-10">
          <draggable 
          v-model="card_sort.card_sort_cards"
          group="cards"
          class="flex"
          :move="onCardMove"
          @end="onCardDrop"
          >            
            <Card 
            v-for="card in card_sort.card_sort_cards"
            :key="card.id"
            :id="card.id"
            :title="card.title"
            :description="card.description"
            classes="flex-shrink-0 w-64 mr-2"
            />
          </draggable>
        </div>
      </div>      
    </div>  
  </div>
</template>

<script>
  import Rails from '@rails/ujs'
  import draggable from 'vuedraggable'
  import Card from '../components/card_sort_participants/card.vue'
  import Group from '../components/card_sort_participants/group.vue'

  export default {
    props: { 
      data: Object,
      preview: Boolean
    },
    data () {
      return {
        card_sort: this.data,
        groups: this.data.card_sort_groups.map(function (group) {
          return { 
            id: group.id, 
            name: group.name,
            can_delete: false, 
            cards: []
          }
        }),
        step: 'sort',
        array: [],
        moving_card: undefined
      }
    },
    computed: {
      groups_index: function() {
        var group_indices = this.groups.map(group => group.id)
        return (Math.max(...group_indices) + 1)
      }
    },
    created: function() {
      //this.addGroup()
    },
    methods: {
      addGroup() {
        this.groups = this.groups.concat(this.newGroup())        
      },
      addGroupToGroups(group) {
        this.groups = this.groups.concat(group)  
      },
      newGroup() {
        return {
          id: this.groups_index + 1,
          name: undefined,
          can_delete: true,
          cards: []
        }
      },
      deleteGroup(id) {
        var index = this.groups.findIndex(i => i.id == id)
        var deleted_cards = this.groups[index].cards
        this.groups.splice(index, 1)
        this.card_sort.card_sort_cards = this.card_sort.card_sort_cards.concat(deleted_cards)
      },
      onGroupMove(evt) {
        if(evt.to.id !== 'groups') {
          return false
        }
      },
      updateCards(group_id, cards) {
        var index = this.groups.findIndex(i => i.id == group_id)
        this.groups[index].cards = cards
      },
      onCardMove(evt) {
        if(this.card_sort.sort_type === 'close' || evt.to.id === 'groups') {
          return false
        }
        this.moving_card = evt
      },
      onCardDrop(evt) {
        if(evt.to.id === 'groups') {
          var index = this.moving_card.draggedContext.futureIndex          
          var new_group = this.newGroup()
          new_group.cards = [this.moving_card.draggedContext.element]
          this.groups.splice(index, 1)
          this.groups.splice(index, 0, new_group)
        }
      }
    },
    components: { draggable, Card, Group }
  }
</script>