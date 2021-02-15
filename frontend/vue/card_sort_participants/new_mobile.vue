<template>
  <div class="h-screen">
    <div v-show="step  === 'intro'" class="min-h-screen bg-gray-50">
      <PreviewBanner v-show="preview" study_type="card sort">        
      </PreviewBanner>
      <InfoBox
        :logo_url="card_sort.logo_url"
        heading="Welcome!"
        button_label="Continue"
        @buttonClick="step = 'instructions'"
      >
        <div class="max-w-xl text-md leading-5 text-gray-700"> {{ card_sort.participant_instructions }}
        </div>        
      </InfoBox>
    </div>
    <div v-show="step === 'instructions'" class="min-h-screen bg-gray-50"> 
      <PreviewBanner v-show="preview" study_type="card sort">        
      </PreviewBanner>
      <InfoBox
        :logo_url="card_sort.logo_url"
        heading="Instructions"
        button_label="Get Started"
        @buttonClick="startSort()"
      >
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
                <img :src="card_sort_gif_url">
              </div>
            </div>
          </div>
        </div>        
      </InfoBox>               
    </div>  
    <div class="h-screen flex flex-col" v-show="step === 'sort'">
      <PreviewBanner v-show="preview" study_type="card sort">        
      </PreviewBanner>       
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
          <div v-if="playback" class="ml-4 mt-4 flex items-center">
            <span class="shadow-sm rounded-md">
              <button @click="replay(true)" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                <svg class="-ml-1 mr-2 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM13.7071 8.70711C14.0976 8.31658 14.0976 7.68342 13.7071 7.29289C13.3166 6.90237 12.6834 6.90237 12.2929 7.29289L9 10.5858L7.70711 9.29289C7.31658 8.90237 6.68342 8.90237 6.29289 9.29289C5.90237 9.68342 5.90237 10.3166 6.29289 10.7071L8.29289 12.7071C8.68342 13.0976 9.31658 13.0976 9.70711 12.7071L13.7071 8.70711Z"/>
                </svg>
                Replay
              </button>
            </span>
          </div>          
          <div v-else class="ml-4 mt-4 flex items-center">
            <span class="invisible sm:visible flex-1 self-center mr-4 text-sm leading-5 font-medium">
                All done?
            </span>
            <span class="shadow-sm rounded-md">
              <button @click="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                <svg class="-ml-1 mr-2 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM13.7071 8.70711C14.0976 8.31658 14.0976 7.68342 13.7071 7.29289C13.3166 6.90237 12.6834 6.90237 12.2929 7.29289L9 10.5858L7.70711 9.29289C7.31658 8.90237 6.68342 8.90237 6.29289 9.29289C5.90237 9.68342 5.90237 10.3166 6.29289 10.7071L8.29289 12.7071C8.68342 13.0976 9.31658 13.0976 9.70711 12.7071L13.7071 8.70711Z"/>
                </svg>
                Submit
              </button>
            </span>
          </div>
        </div>
      </div>
      <div 
      class="px-6 pt-6 flex-1 flex overflow-y-auto" 
      > 
        <Groups          
          :sort_type="card_sort.sort_type"
          v-model="groups"
          @releaseCards="addCardsToDrawer"
          @cardMove="recordCardMove"
          @saveGroupName="recordGroupNameChange"
        />
      </div>
      <div>
        <div v-show="card_sort.card_sort_cards.length === total_cards" class="mx-auto px-6 py-6 text-center">
          <p class="mb-12">Drag all the cards below into groups that makes sense to you.</p>
          <svg class="mb-12 m-auto h-12 w-12 text-gray-500 animate-bounce" fill="currentColor" viewBox="0 0 24 24" stroke="none">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M5.29289 7.70711C4.90237 7.31658 4.90237 6.68342 5.29289 6.29289L9.29289 2.29289C9.68342 1.90237 10.3166 1.90237 10.7071 2.29289L14.7071 6.29289C15.0976 6.68342 15.0976 7.31658 14.7071 7.70711C14.3166 8.09763 13.6834 8.09763 13.2929 7.70711L11 5.41421L11 17C11 17.5523 10.5523 18 10 18C9.44772 18 9 17.5523 9 17L9 5.41421L6.70711 7.70711C6.31658 8.09763 5.68342 8.09763 5.29289 7.70711Z"/>
          </svg>
        </div> 
        <transition name="slide-in">
          <div class=""> 
            <div v-show="step === 'sort'" class="flex overflow-x-auto bg-gray-200 px-6 py-12 m:px-6 sm:py-12 border-t-4">
              <draggable 
              v-model="card_sort.card_sort_cards"
              group="cards"
              ghost-class="draggable-new-group2"
              class="flex draggable w-full"
              id="drawer"
              @add="recordCardMove"
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
        </transition>
      </div>
    </div>  
    <div v-show="step === 'thanks'" class="min-h-screen bg-gray-50">
      <PreviewBanner v-show="preview" study_type="card sort">        
      </PreviewBanner>  
      <InfoBox
        :logo_url="card_sort.logo_url"
        heading="Thank you!"
        @buttonClick="step = 'instructions'"
        :show_button="false"
      >
        <div class="max-w-xl text-md leading-5 text-gray-500">
          <p>
            Thanks for taking the time to help us. Your contribution is essential in our journey to deliver improvements!
          </p>
        </div>      
      </InfoBox>                
    </div>
    <InstructionsModal
      :show="instructions_modal_open"
      @close="instructions_modal_open = false"
    >
    </InstructionsModal>
    <ErrorModal
      :show="error_modal_open"
      :error_message="error_message"
      @close="error_message = undefined; error_modal_open = false"
    >
    </ErrorModal>
  </div>
</template>

<script>
  import Rails from '@rails/ujs'
  import draggable from 'vuedraggable'
  import Card from '../components/card_sort_participants/card.vue'
  import Groups from '../components/card_sort_participants/mobile/groups.vue'
  import PreviewBanner from '../components/study_preview_banner.vue'
  import InfoBox from '../components/participant_view_information_box.vue'
  import ErrorModal from '../components/participant_view_error_modal.vue'
  import InstructionsModal from '../components/participant_view_instructions_modal.vue'

  export default {
    props: { 
      data: Object,
      preview: Boolean,
      card_sort_gif_url: String,
      playback: {
        type: Boolean,
        default: false
      },
      saved_recording: String
    },
    data: function() {
      return {
        card_sort: this.data,
        groups: [],
        total_cards: this.data.card_sort_cards.length,
        recording: this.saved_recording ? JSON.parse(this.saved_recording) : [],
        final_groups: undefined,
        step: this.playback? 'sort' : 'sort',
        instructions_modal_open: false,
        error_modal_open: false,
        error_message: undefined,
        sort_start_time: undefined,
        sort_time_elapsed: undefined,
        finished_saving_groups: undefined,
        last_card_move_time: undefined
      }
    },
    created() {
      this.card_sort.card_sort_groups.forEach(group => {        
        var groupObject = {
          id: group.id.toString(),
          name: group.name,
          can_delete: false,
          can_edit_name: false,
          cards: []
        }
        this.groups.push(groupObject)
      })
    },
    computed: {
    },
    watch: {
      finished_saving_groups: function(val) {
        if(val === 0) {
          this.saveSorts()
        }
      }
    },
    methods: {
      recordCardMove(event) {
        var move = {
          type: 'card_move',
          from: event.from.id,
          fromIndex: event.oldIndex,
          to: event.to.id, 
          toIndex: event.newIndex,
        }        
        this.recordAction(move)
      },
      recordGroupNameChange(event) {
        window.console.log('abc')
        var groupNameChange = {
          type: 'group_name_change',
          group: event.group,
          name: event.name
        }
        this.recordAction(groupNameChange)
      },
      recordAction(action) {
        var now = new Date
        var time = this.last_card_move_time ? (now - this.last_card_move_time) : (now - this.sort_start_time)
        this.last_card_move_time = now
        action.time = time 
        this.recording.push(action)       
      },
      replay(first, actionIndex = 0) {
        var action = this.recording[actionIndex]
        if(first) {
          setTimeout(() => this.replay(false), this.recording[0].time)
        } else {
          this.replayAction(action)
          if(this.recording[actionIndex + 1]) {
            setTimeout(() => this.replay(false, actionIndex + 1), this.recording[actionIndex + 1].time)
          }
        }
      },
      replayAction(action) {
        if(action.type === 'card_move') {
          this.replayMove(action)
        } else if(action.type === 'group_name_change') {
          this.replayGroupNameChange(action)
        }
      },
      replayGroupNameChange(action) {
        var [_, group_column, group_index] = action.group.split('_')
        this.$refs.group_column[group_column].groups[group_index].name = action.name
      },
      replayMove(action) {
        var move = action
        var card, from_group_column, from_group_index, _

        if(move.from === 'drawer') {
          card = this.card_sort.card_sort_cards[move.fromIndex]
          this.card_sort.card_sort_cards.splice(move.fromIndex, 1)
        } else if(move.from.includes('group_')) {
          [_, from_group_column, from_group_index] = move.from.split('_')
          card = this.$refs.group_column[from_group_column].$refs.group[from_group_index].cards[move.fromIndex]
          this.$refs.group_column[from_group_column].$refs.group[from_group_index].cards.splice(move.fromIndex, 1)
        }

        var to_group_column, to_group_index
        if(move.to.includes('groupcolumn_')) {
          to_group_column = move.to.split('_')[1]
          this.$refs.group_column[to_group_column].groups.splice(move.toIndex, 0, card)
        } else if(move.to.includes('group_')) {
          [_, to_group_column, to_group_index] = move.to.split('_')
          this.$refs.group_column[to_group_column].$refs.group[to_group_index].cards.splice(move.toIndex, 0, card)
        } else if(move.to === 'drawer') {
          this.card_sort.card_sort_cards.splice(move.toIndex, 0, card)
        }
      },      
      addCardsToDrawer(cards) {
        this.card_sort.card_sort_cards = this.card_sort.card_sort_cards.concat(cards)
      },
      startSort() {
        this.step = 'sort'
        this.sort_start_time = new Date        
      },
      saveGroups() {
        this.final_groups = this.groups.flat()
        this.finished_saving_groups = this.final_groups.filter(group => group.can_delete).length
        this.final_groups.forEach((group, index) => {
          if(group.can_delete) {
            var data = new FormData
            data.append('card_sort_group[name]', group.name)
            data.append('card_sort_group[card_sort_id]', this.card_sort.id)
            Rails.ajax({
              url: '/participant_designated_card_sort_groups',
              type: 'POST', 
              data: data,
              success:  (arg) => {
                this.final_groups[index].id = arg.id   
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
        data.append('card_sort_participant[sort]', JSON.stringify({'columns': this.groups}))
        data.append('card_sort_participant[recording]', JSON.stringify(this.recording))
        var index = -1 
        this.final_groups.forEach((group) => {
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
          this.error_message = 'Please sort all the cards from the bottom of the screen.'
          this.error_modal_open = true
        } else if(this.groups.flat().findIndex(group => group.name === undefined) !== -1) {
          this.error_message = 'Please create names for all your groups.'
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
    components: { draggable, Card, Groups, PreviewBanner, InfoBox, ErrorModal, InstructionsModal }
  }
</script>