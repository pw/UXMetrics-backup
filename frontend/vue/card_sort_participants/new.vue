<template>
  <div>
    <div v-show="step  === 'intro'" class="min-h-screen bg-gray-50">
      <main class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="bg-white sm:rounded-lg shadow mb-6">
            <div class="px-4 py-5 sm:p-6">
              <img v-if="card_sort.logo_key !== 'undefined'" :src="card_sort.logo_url" class="mb-6 w-40">
              <img v-else :src="card_sort.logo_url" class="mb-6" width="76" height="39">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Welcome!
              </h3>
              <div class="max-w-xl text-md leading-5 text-gray-700"> {{ card_sort.participant_instructions }}
              </div>
              <div class="mt-5">
                <span class="shadow-sm rounded-md">
                  <a @click="step = 'instructions'" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out cursor-pointer">
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
    <div v-show="step === 'instructions'" class="min-h-screen bg-gray-50">
      <main class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="bg-white sm:rounded-lg shadow mb-6">
            <div class="px-4 py-5 sm:p-6">
              <img v-if="card_sort.logo_key !== 'undefined'" :src="card_sort.logo_url" class="mb-6 w-40">
              <img v-else :src="card_sort.logo_url" class="mb-6" width="76" height="39">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Instructions
              </h3>
              <div class="grid grid-cols-1 col-gap-4 row-gap-8 md:grid-cols-2">
                <div class="sm:col-span-1">
                  <div class="mb-6 text-md leading-5 text-gray-700">
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
                  <a @click="startSort()" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out cursor-pointer">
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
              <button @click="instructions_modal_open = true" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
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
              <button @click="submit()"class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
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
        class="flex flex-wrap -mx-2 draggable" 
        group="cards"
        swap-threshold="0.65"
        ghost-class="draggable-new-group"
        @updateCards="updateCards"  
        :move="onGroupMove"
        >
          <Group
          v-for="group in groups"
          :key="group.id"
          :sort_type="card_sort.sort_type"
          :id="group.id"   
          :can_delete="group.can_delete"
          :initial_cards="group.cards"
          v-model="group.name" 
          @updateCards="updateCards"
          @addGroup="addGroup"
          @deleteGroup="deleteGroup"
          @onCardMove="onCardMove"
          @onCardDrop="onCardDrop"
          />
        </draggable>
      </div>
      <div class="fixed inset-x-0 bottom-0 w-full">
        <div v-show="card_sort.card_sort_cards.length === total_cards" class="m-auto px-6 py-6 text-center">
          <p class="mb-12">Drag all the cards below into groups that makes sense to you.</p>
          <svg class="mb-12 m-auto h-12 w-12 text-gray-500 animate-bounce" fill="currentColor" viewBox="0 0 24 24" stroke="none">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M5.29289 7.70711C4.90237 7.31658 4.90237 6.68342 5.29289 6.29289L9.29289 2.29289C9.68342 1.90237 10.3166 1.90237 10.7071 2.29289L14.7071 6.29289C15.0976 6.68342 15.0976 7.31658 14.7071 7.70711C14.3166 8.09763 13.6834 8.09763 13.2929 7.70711L11 5.41421L11 17C11 17.5523 10.5523 18 10 18C9.44772 18 9 17.5523 9 17L9 5.41421L6.70711 7.70711C6.31658 8.09763 5.68342 8.09763 5.29289 7.70711Z"/>
          </svg>
        </div>        
        <div class="flex overflow-x-auto bg-gray-200 px-6 pt-6 pb-4 sm:px-6 sm:pt-12 sm:pb-10 animate__animated animate__slideInRight">
          <draggable 
          v-model="card_sort.card_sort_cards"
          group="cards"
          class="flex draggable"
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
    <div v-show="step === 'thanks'" class="min-h-screen bg-gray-50">
      <main class="py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="bg-white sm:rounded-lg shadow mb-6">
            <div class="px-4 py-5 sm:p-6">
              <img v-if="card_sort.logo_key !== 'undefined'" :src="card_sort.logo_url" class="mb-6 w-40">
              <img v-else :src="card_sort.logo_url" class="mb-6" width="76" height="39">
              <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
                Thank you!
              </h3>
              <div class="max-w-xl text-md leading-5 text-gray-500">
                <p>
                Thanks for taking the time to help us. Your contribution is essential in our journey to deliver improvements!
                </p>
              </div>
            </div>
          </div>
        </div>
      </main>      
    </div>
    <transition name="modal-component">
      <div v-show="instructions_modal_open" class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
        <transition name="overlay">
          <div v-show="instructions_modal_open" class="fixed inset-0 transition-opacity">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
          </div>
        </transition>
        <transition name="modal">
          <div v-show="instructions_modal_open" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-7xl sm:w-full max-h-full overflow-y-auto">
            <div class="flex items-center justify-between flex-wrap sm:flex-no-wrap border-b border-gray-200 px-4 py-5 sm:px-6">
              <h2 class="text-lg leading-6 font-medium text-gray-900">
                  Instructions
              </h2>
              <button @click="instructions_modal_open = false" type="button" class="text-gray-400 hover:text-gray-500 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150">
                <svg class="h-6 w-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
            </div>
            <div class="px-4 py-5 sm:p-6">
              <div class="grid grid-cols-1 col-gap-4 row-gap-8 md:grid-cols-2">
                <div class="sm:col-span-1">
                  <div class="mb-6">
                    <p class="mb-3">
                        We'd like you to categorize the cards at the bottom of the screen cards into groups that make sense to you. You can do this by dragging and dropping them into the area above.
                    </p>
                    <p class="mb-3">
                        There are no right or wrong answers, just do what makes sense to you!
                    </p>
                    <p>
                        When you're finished, click the green "Submit" button at the top right.
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
            </div>
              <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
                <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
                  <button @click="instructions_modal_open = false" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
                      Close
                  </button>
                </span>
              </div>
          </div>
        </transition>
      </div> 
    </transition>
    <transition name="modal-component">
      <div v-show="error_modal_open" class="fixed bottom-0 inset-x-0 px-4 pb-4 sm:inset-0 sm:flex sm:items-center sm:justify-center">
        <transition name="overlay">
          <div v-show="error_modal_open" class="fixed inset-0 transition-opacity">
            <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
          </div>
        </transition>

        <transition name="modal">
          <div v-show="error_modal_open" class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-xl sm:w-full max-h-full overflow-y-auto">
            <div class="px-4 py-5 sm:p-6">
              <div>
                <div class="mb-6 mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-red-100">
                  <svg class="h-6 w-6 text-red-600" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                  </svg>
                </div>
                <p v-show="error_type == 'cards'" class="text-center">
                    Please sort all the cards from the bottom of the screen.
                </p>
                <p v-show="error_type == 'group names'" class="text-center">
                    Please create names for all your groups.
                </p>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
              <span class="mt-3 flex w-full rounded-md shadow-sm sm:mt-0 sm:w-auto">
                <button @click="error_type = undefined; error_modal_open = false" type="button" class="inline-flex justify-center w-full rounded-md border border-gray-300 px-4 py-2 bg-white text-base leading-6 font-medium text-gray-700 shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline transition ease-in-out duration-150 sm:text-sm sm:leading-5">
                    OK
                </button>
              </span>
            </div>
          </div>
        </transition>
      </div>       
    </transition>
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
        step: 'intro',
        array: [],
        moving_card: undefined,
        total_cards: this.data.card_sort_cards.length,
        instructions_modal_open: false,
        error_modal_open: false,
        error_type: undefined,
        sort_start_time: undefined,
        sort_time_elapsed: undefined,
        finished_saving_groups: undefined
      }
    },
    computed: {
      groups_index: function() {
        var group_indices = this.groups.map(group => group.id)
        return (Math.max(...group_indices) + 1)
      }
    },
    watch: {
      finished_saving_groups: function(val) {
        if(val === 0) {
          this.saveSorts()
        }
      }
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
      removeEmptyGroups() {
        var empty_groups = this.groups.filter(group => group.cards.length === 0 && group.can_delete)
        empty_groups.forEach(group => this.deleteGroup(group.id))
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
        if(this.card_sort.sort_type === 'closed' && evt.to.id === 'groups') {
          return false
        }
        this.moving_card = evt
      },
      onCardDrop(evt) {
        if(evt.to.id === 'groups' && this.card_sort.sort_type !== 'closed') {
          var index = this.moving_card.draggedContext.futureIndex          
          var new_group = this.newGroup()
          new_group.cards = [this.moving_card.draggedContext.element]
          this.groups.splice(index, 1)
          this.groups.splice(index, 0, new_group)
        }
        this.removeEmptyGroups()
      },
      startSort() {
        this.step = 'sort'
        this.sort_start_time = new Date
      },
      saveGroups() {
        this.finished_saving_groups = this.groups.filter(group => group.can_delete).length
        this.groups.forEach((group, index) => {
          if(group.can_delete) {
            var data = new FormData
            data.append('card_sort_group[name]', group.name)
            data.append('card_sort_group[card_sort_id]', this.card_sort.id)
            Rails.ajax({
              url: '/participant_designated_card_sort_groups',
              type: 'POST', 
              data: data,
              success:  (arg) => {
                this.groups[index].id = arg.id   
                this.finished_saving_groups -= 1
              }
            })        
          }  
        })
      },     
      saveSorts() {
        var data = new FormData
        data.append('card_sort_participant[card_sort_id]', this.card_sort.id)
        data.append('card_sort_participant[time]', this.sort_time_elapsed)
        var index = -1 
        this.groups.forEach((group) => {
          group.cards.forEach((card) => {
            index += 1
            data.append('card_sort_participant[card_sort_sorts_attributes][' + index + '][card_sort_id]', this.card_sort.id)
            data.append('card_sort_participant[card_sort_sorts_attributes][' + index + '][card_sort_group_id]', group.id)
            data.append('card_sort_participant[card_sort_sorts_attributes][' + index + '][card_sort_card_id]', card.id)
          })
        })
        Rails.ajax({
          url: '/card_sort_participants',
          type: 'POST',
          data: data,
          success: (arg) => {
            this.step = 'thanks'
          }
        })
      },
      submit() {
        if(this.card_sort.card_sort_cards.length != 0) {
          this.error_type = 'cards'
          this.error_modal_open = true
        } else if(this.groups.findIndex(group => group.name === undefined) !== -1) {
          this.error_type = 'group names'
          this.error_modal_open = true
        } else if(this.preview) {
          this.step = 'thanks'
          return
        } else {
          var endTime = new Date
          this.sort_time_elapsed = (endTime - this.sort_start_time)
          this.saveGroups()       
        }
      }
    },
    components: { draggable, Card, Group }
  }
</script>