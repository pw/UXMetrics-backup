<template>
  <div>
    <Nav :title="title" :step="card_sort.creation_step" @back="back"/>
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
      <ul class="space-y-4 md:flex md:space-y-0 md:space-x-8">
        <li class="md:flex-1">
          <div class="group pl-4 py-2 block border-l-4 border-purple-600 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-purple-600 font-semibold uppercase">Step 1</h3>
            <p class="text-sm leading-5 font-medium">Study Setup</p>
          </div>
        </li>

        <li class="md:flex-1">
          <div 
          class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4"
          :class="{'border-purple-600': (card_sort.creation_step >= 2)}">
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 2</h3>
            <p class="text-sm leading-5 font-medium">Add Cards</p>
          </div>
        </li>

        <li class="md:flex-1">
          <div class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4"
          :class="{'border-purple-600': (card_sort.creation_step >= 3)}">
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 3</h3>
            <p class="text-sm leading-5 font-medium">Advanced Options</p>
          </div>
        </li>
      </ul>
    </nav>
    <Step 
    v-show="card_sort.creation_step == 1"
    @next="next"
    instructions="Let's start with the basics to set up your study. Then we'll create your cards.">    
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextInput id="name" ref="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your study..." 
        v-model="card_sort.name"
        @blur="saveProperty('name')"
        />
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with an introduction" 
        v-model="card_sort.participant_instructions" 
        @blur="saveProperty('participant_instructions')"
        />
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" 
        v-model="card_sort.thank_you_message" 
        @blur="saveProperty('thank_you_message')"
        />
      </div>       
    </Step>
    
    <Step v-show="card_sort.creation_step == 2" @next="next" instructions="Now let's choose your sort type and add your cards.">
      <div class="mb-6 pb-6 border-b border-gray-100">
        <SortType 
        v-model="card_sort.sort_type" 
        :enabled="true"
        />
      </div>
      <div v-show="(card_sort.sort_type === 'closed') || (card_sort.sort_type === 'hybrid')" class="sm:col-span-4">
        <div class="mb-6 pb-6 border-b border-gray-100">
          <label for="logo" class="mb-2 block text-sm leading-5 font-medium text-gray-700">
            Pre-Defined Groups
          </label>
          <draggable
            v-model="groups"
            ghost-class="group-list-ghost-class"
          >
            <Group
              v-for="group in groups"
              :key="group.id"
              ref="group_refs" 
              v-model="group.name" 
              :group_id="group.id" 
              @remove="removeGroup" 
              @nextGroup="nextGroup"
            />
          </draggable>

          <span class="shadow-sm rounded-md">
            <button @click="addGroup" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
                </svg>
                New Group
            </button>
          </span>
        </div>  
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <div class="sm:col-span-4">
          <label for="logo" class="mb-2 block text-sm leading-5 font-medium text-gray-700">
            Cards
          </label>
          <draggable
            v-model="cards"
            ghost-class="group-list-ghost-class"
          >
            <Card 
              v-for="(card, index) in cards"
              ref="card_refs" 
              :value="card"
              @input="$set(cards, index, $event)"
              @removeCard="removeCard" 
              @nextCard="nextCard" 
            />           
          </draggable>                 
          <span class="shadow-sm rounded-md">
            <button @click="addCard" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
              <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
              </svg>
              New Card
            </button>
          </span>
        </div>                    
      </div>
    </Step>

    <Step v-show="card_sort.creation_step == 3" @next="next" instructions="Enhance your study with some optional upgrades.">
      <div class="bg-purple-50 sm:rounded-md px-4 py-6 mb-6 flex items-end">
        <div>
          <h4 class="text-lg leading-7 font-medium mb-2">Upgrade to Pro for just $99/year (optional)</h4>
          <p class="text-sm leading-5 font-light">Take your research to the next level. Unlock advanced options on all your studies.</p>
        </div>
        <span class="shadow-sm rounded-md flex-shrink-0">
          <a class="back-btn inline-flex items-center cursor-pointer px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:shadow-outline focus:border-blue-300 transition duration-150 ease-in-out">
            Upgrade to Pro
          </a>
        </span>  
      </div>
      <LogoUpload
      class="mb-6 pb-6 border-b border-gray-100"
      v-model="card_sort.logo_key"
      @input="saveProperty('logo_key')"
      instructions="Add branding to this study"
      :logo_base_url="card_sort.logo_base_url"
      :enabled="card_sort.subscribed"
      />
      <Slider class="mb-6 pb-6 border-b border-gray-100" v-model="card_sort.randomize_card_order" :enabled="card_sort.subscribed" @input="saveProperty('randomize_card_order')" label="Randomize card order for each participant" description="This ensures that each card has a chance to be sorted earlier in the session," />
      <Slider class="mb-6 pb-6 border-b border-gray-100" v-model="card_sort.shareable" :enabled="card_sort.subscribed" @input="saveProperty('shareable')" label="Shareable report" description="Your study report is publically available via an unlisted URL" />    
      <Slider class="mb-6 pb-6" v-model="card_sort.randomize_card_order" :enabled="card_sort.subscribed" @input="saveProperty('shareable')" label="Password protect your reports" description="Keep reports private and securely share access with clients" />    
    </Step>

    <Flash v-show="show_flash" :show="show_flash" :notice="flash_notice">
    </Flash>
  </div>
</template>

<script>
import Nav from '../components/creation_nav.vue'
import Step from '../components/creation_step.vue'
import TextInput from '../components/new_tree_test/text_input.vue'
import TextArea from '../components/new_tree_test/text_area.vue'
import Slider from '../components/slider.vue'
import draggable from 'vuedraggable'
import Group from '../components/new_card_sort/group.vue'
import Card from '../components/new_card_sort/card.vue'
import Flash from '../components/flash.vue'
import SaveAndContinue from '../components/creation_save_and_continue.vue'
import LogoUpload from '../components/logo_upload.vue'
import SortType from '../components/sort_type_selector.vue'

import Rails from '@rails/ujs'

export default {
  props: {
    data: Object
  },
  data () {
    return {
      card_sort: this.data,
      show_flash: false,
      flash_notice: '',
      name: '', 
      groups: [
        {
          id: 0,
          name: '',
        }       
      ],      
      group_index: 0,
      cards: [
        {
          id: 0,
          title: '',
          description: '',
          has_description: false
        }
      ],
      card_index: 0
    }
  },
  methods: {
    next: function() {
      if(this.card_sort.creation_step === 1 && this.card_sort.name === '') {
        this.flash_notice = 'Name cannot be blank'
        this.showFlash()
        this.$refs.name.$refs.input.focus()
      } else {
        this.card_sort.creation_step += 1
        this.saveProperty('creation_step')
      }
    },
    back: function() {
      this.card_sort.creation_step -= 1
    },
    showFlash: function() {
      this.show_flash = true
      setTimeout(() => this.show_flash = false, 5000)
    },
    addGroup: function() {
      this.group_index += 1
      this.groups.push({id: this.group_index, name: ''})
    },
    removeGroup: function(id) {       
      var index = this.groups.findIndex(i => i.id == id)
      this.groups.splice(index, 1)
    },
    nextGroup: function(group_id) {
      var index = this.groups.findIndex(i => i.id == group_id)
      if(index === this.groups.length - 1) {
        this.addGroup()       
      } 
      this.$nextTick(function() {
        this.$refs.group_refs[index + 1].$refs.input.focus()
      }) 
    }, 
    addCard: function() {
      this.card_index += 1
      this.cards.push({id: this.card_index, title: '', description: '', has_description: false })
      this.$nextTick(function() {
        this.$refs.card_refs[this.cards.length - 1].$refs.title.focus()
      })       
    },
    removeCard: function(id) {
      var index = this.cards.findIndex(i => i.id == id)
      this.cards.splice(index, 1)      
    },  
    nextCard: function(card_id) {
      var index = this.cards.findIndex(i => i.id == card_id)
      if(index === this.cards.length - 1) {
        this.addCard()      
      } else {     
        this.$nextTick(function() {
          this.$refs.card_refs[index + 1].$refs.title.focus()
        })    
      }    
    },         
    save() {
      var data = new FormData
      data.append('card_sort[name]', this.name)
      data.append('card_sort[logo_key]', this.logo_key)
      data.append('card_sort[participant_instructions]', this.participant_instructions)
      data.append('card_sort[thank_you_message]', this.thank_you_message)
      data.append('card_sort[sort_type]', this.sort_type)
      if(this.sort_type !== 'open') {     
        this.groups.forEach((group, index) => {
          if(group.name === '') {          
          } else {
            data.append('card_sort[card_sort_groups_attributes][' + index + '][name]', group.name) 
            data.append('card_sort[card_sort_groups_attributes][' + index + '][order]', index)   
          }     
        })
      }
      data.append('card_sort[randomize_card_order]', this.randomize_card_order) 
      this.cards.forEach((card, index) => {
        if(card.title === '') {
        } else {
          data.append('card_sort[card_sort_cards_attributes][' + index + '][title]', card.title)   
          data.append('card_sort[card_sort_cards_attributes][' + index + '][description]', card.description)
          data.append('card_sort[card_sort_cards_attributes][' + index + '][has_description]', card.has_description)
          data.append('card_sort[card_sort_cards_attributes][' + index + '][order]', index)      
        }              
      })

      Rails.ajax({
        url: '/card_sorts',
        type: 'POST', 
        data: data,
        dataType: 'json'
      })
    },
    saveProperty(property) {
      var data = new FormData 
      data.append('card_sort[' + property + ']', this.card_sort[property])
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort.id,
        type: 'PATCH', 
        data: data
      }) 
    }     
  },
  computed: {
    title: function() {
      if(this.card_sort.name) {
        return this.card_sort.name
      } else {
        return 'New Card Sort'
      }
    }
  },
  watch: {
    card_sort: {
      deep: true, 
      handler() {
        console.log('card_sort changed')
      }
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, draggable, Group, Card, Flash, SaveAndContinue, LogoUpload, SortType }
}
</script>