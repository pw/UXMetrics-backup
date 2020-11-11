<template>
  <div>
    <Nav :title="title" :step.sync="step" :total_steps="total_steps" @save="save"/>
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
      <ul class="space-y-4 md:flex md:space-y-0 md:space-x-8">
        <li class="md:flex-1">
          <!-- Completed Step -->
          <div class="group pl-4 py-2 block border-l-4 border-purple-600 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-purple-600 font-semibold uppercase">Step 1</h3>
            <p class="text-sm leading-5 font-medium">Study Setup</p>
          </div>
        </li>

        <li class="md:flex-1">
          <!-- Upcoming Step -->
          <div class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 2</h3>
            <p class="text-sm leading-5 font-medium">Add Cards</p>
          </div>
        </li>

        <li class="md:flex-1">
          <!-- Upcoming Step -->
          <div class="group pl-4 py-2 block border-l-4 border-gray-200 md:pl-0 md:pt-4 md:pb-0 md:border-l-0 md:border-t-4">
            <h3 class="text-xs leading-4 text-gray-500 font-semibold uppercase">Step 3</h3>
            <p class="text-sm leading-5 font-medium">Preview and Publish</p>
          </div>
        </li>
      </ul>
    </nav>
    <Step v-show="step == 1" current_step="1" :total_steps="total_steps" instructions="Let's start with the basics to set up your study. Then we'll create your cards.">
      <form>
        <div class="shadow sm:rounded-md sm:overflow-hidden">
          <div class="px-4 py-5 bg-white sm:p-6">
            <div class="mb-6 pb-6 border-b border-gray-100">
              <TextInput id="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your study..." v-model="name"/>
            </div>
            <div class="mb-6 pb-6 border-b border-gray-100">
              <div class="sm:col-span-4">
                <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
                    Logo
                </label>
                <p class="mb-2 text-sm text-gray-500">Add your branding to this study (optional)</p>
                <img v-show="logo_key !== undefined" :src="logo_base_url + '/' + logo_key" class="mb-6 w-40">
                <div class="mt-2 flex items-center">
                  <span class="rounded-md shadow-sm">
                    <button @click="openUpload" type="button" class="py-2 px-3 border border-gray-300 rounded-md text-sm leading-4 font-medium text-gray-700 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-50 active:text-gray-800 transition duration-150 ease-in-out">
                        Choose File
                    </button>
                  </span>
                </div>
              </div>
            </div>
            <div class="mb-6 pb-6 border-b border-gray-100">
              <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with an introduction" v-model="participant_instructions" />
            </div>
            <div class="">
              <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" v-model="thank_you_message" />
            </div>
          </div>
          <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
            <span class="inline-flex rounded-md shadow-sm">
              <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
                Save and Continue
              </button>
            </span>
          </div>
        </div>
      </form>
    </Step>
    
    <Step v-show="step == 2" current_step="2" :total_steps="total_steps" instructions="Now let's choose your sort type and add your cards.">
      <div class="shadow sm:rounded-md sm:overflow-hidden">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="mb-6 pb-6 border-b border-gray-100">
            <div class="sm:col-span-4">
              <label for="sort_type" class="mb-2 block text-sm leading-5 font-medium text-gray-700">
                  Sort Type
              </label>
              <div 
              @click="sort_type = 'open'"
              :class="{'bg-purple-100 hover:bg-purple-200 border border-purple-600': (sort_type === 'open'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'open')}" class=" cursor-pointer overflow-hidden shadow rounded-lg  mb-3 transition duration-150 ease-in-out">
                <div class="p-2 sm:p-3">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 p-1">
                      <input v-model="sort_type" id="open_sort" name="sort_type" value="open" aria-label="open" type="radio" checked class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
                    </div>
                    <div class="ml-2 w-0 flex-1">
                      <p class="text-sm leading-5 font-medium text-gray-700">Open</p>
                      <p class="text-sm text-gray-500">Participants sort cards into groups they create and name</p>
                    </div>
                  </div>
                </div>
              </div>
              <div 
              @click="sort_type = 'closed'"
              :class="{'bg-purple-100 hover:bg-purple-200 border border-purple-600': (sort_type === 'closed'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'closed')}" class="cursor-pointer overflow-hidden shadow rounded-lg mb-3 transition duration-150 ease-in-out">
                <div class="p-2 sm:p-3">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 p-1">
                      <input v-model="sort_type" id="closed_sort" name="sort_type" value="closed" aria-label="closed" type="radio" class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
                    </div>
                    <div class="ml-2 w-0 flex-1">
                      <p class="text-sm leading-5 font-medium text-gray-700">Closed</p>
                      <p class="text-sm text-gray-500">Participants sort cards into groups pre-defined by you</p>
                    </div>
                  </div>
                </div>
              </div>
              <div 
              @click="sort_type = 'hybrid'"
              :class="{'bg-purple-100 hover:bg-purple-200 border border-purple-600': (sort_type === 'hybrid'), 'bg-gray-50 hover:bg-purple-100': (sort_type !== 'hybrid')}" class="cursor-pointer overflow-hidden shadow rounded-lg mb-3 transition duration-150 ease-in-out">
                <div class="p-2 sm:p-3">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 p-1">
                      <input v-model="sort_type" id="hybrid_sort" name="sort_type" value="hybrid" aria-label="hybrid" type="radio" class="h-4 w-4 border-gray-300 text-purple-600 focus:shadow-outline-purple focus:border-purple-300 transition duration-150 ease-in-out" />
                    </div>
                    <div class="ml-2 w-0 flex-1">
                      <p class="text-sm leading-5 font-medium text-gray-700">Hybrid</p>
                      <p class="text-sm text-gray-500">Participants sort cards into pre-defined groups but can also create and name their own groups</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-show="(sort_type === 'closed') || (sort_type === 'hybrid')" class="sm:col-span-4">
            <div class="mb-6 pb-6 border-b border-gray-100">
              <label for="logo" class="mb-2 block text-sm leading-5 font-medium text-gray-700">
                Pre-Defined Groups
              </label>
              <vue-nestable :maxDepth="1" v-model="groups">
                <vue-nestable-handle
                  slot-scope="{ item }"
                  :item="item">
                  <Group :ref="`group_${item.id}`" v-model="item.name" :group_id="item.id" @remove="removeGroup" @nextGroup="nextGroup" @previousGroup="previousGroup" />
                </vue-nestable-handle>      
              </vue-nestable>

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

              <vue-nestable :maxDepth="1" v-model="cards">
                <vue-nestable-handle
                  slot-scope="{ item }"
                  :item="item">
                  <Card :ref="`card_${item.id}`" :card_id="item.id" :starting_title="item.content.title" :starting_description="item.content.description" @updateCard="updateCard" @removeCard="removeCard" @nextCard="nextCard" />
                </vue-nestable-handle>      
              </vue-nestable>
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
          <div class="">
            <Slider v-model="randomize_card_order" label="Randomize card order for each participant" description="This ensures that each card has a chance to be sorted earlier in the session" />
          </div>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <span class="inline-flex rounded-md shadow-sm">
            <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
              Save and Continue
            </button>
          </span>
        </div>                  
      </div>    
    </Step>

  </div>
</template>

<script>
import Nav from '../components/new_tree_test/nav.vue'
import Step from '../components/new_tree_test/step.vue'
import TextInput from '../components/new_tree_test/text_input.vue'
import TextArea from '../components/new_tree_test/text_area.vue'
import Slider from '../components/slider.vue'
import Group from '../components/new_card_sort/group.vue'
import Card from '../components/new_card_sort/card.vue'

import Rails from '@rails/ujs'
import * as filestack from 'filestack-js'
const filestack_client = filestack.init('AuALnf2VzTPqJAkEOLar1z');

export default {
  props: {
    data: Object
  },
  data () {
    return {
      step: 1,
      total_steps: 2,
      name: '', 
      logo_base_url: this.data.logo_base_url,
      logo_key: undefined,
      filestack_options: {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*']        
      },
      participant_instructions: "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Our goal is to learn how you think about, organize and label certain topics into groups.",
      thank_you_message: "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements.",
      sort_type: 'open',
      groups: [
        {
          id: 0,
          name: '',
        }       
      ],      
      group_index: 0,
      randomize_card_order: false,
      cards: [
        {
          id: 0,
          content: {
            title: '',
            description: '',
            has_description: false
          }
        }
      ],
      card_index: 0
    }
  },
  methods: {
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
        this.$nextTick(function() {
          this.$refs[`group_${this.group_index}`].$refs.input.focus()
        })        
      } else {
        this.$nextTick(function() {
          this.$refs[`group_${this.groups[index + 1].id}`].$refs.input.focus()
        })          
      }
    }, 
    previousGroup: function(group_id) {
      var index = this.groups.findIndex(i => i.id == group_id)
      if((index !== 0) && (this.groups[index].name === '')) {
        this.removeGroup(group_id)
        this.$refs[`group_${this.groups[index - 1].id}`].$refs.input.focus()
      }
    },
    updateCard: function(card_id, content) {
      var index = this.cards.findIndex(i => i.id == card_id)
      this.cards[index].content = content
    },
    addCard: function() {
      this.card_index += 1
      this.cards.push({id: this.card_index, content: { title: '', description: '', has_description: false }})
    },
    removeCard: function(id) {
      var index = this.cards.findIndex(i => i.id == id)
      this.cards.splice(index, 1)      
    },  
    nextCard: function(card_id) {
      var index = this.cards.findIndex(i => i.id == card_id)
      if(index === this.cards.length - 1) {
        this.addCard()
        this.$nextTick(function() {
          this.$refs[`card_${this.card_index}`].$refs.title.focus()
        })        
      } else {
        this.$nextTick(function() {
          this.$refs[`card_${this.cards[index + 1].id}`].$refs.title.focus()
        })          
      }      
    },   
    openUpload() {
      const options = {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*'],
        onUploadDone: (arg) => {
          this.logo_key = arg.filesUploaded[0].key
        }
      }
      filestack_client.picker(options).open()
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
        if(card.content.title === '') {
        } else {
          data.append('card_sort[card_sort_cards_attributes][' + index + '][title]', card.content.title)   
          data.append('card_sort[card_sort_cards_attributes][' + index + '][description]', card.content.description)
          data.append('card_sort[card_sort_cards_attributes][' + index + '][has_description]', card.content.has_description)                    
          data.append('card_sort[card_sort_cards_attributes][' + index + '][order]', index)      
        }              
      })

      Rails.ajax({
        url: '/card_sorts',
        type: 'POST', 
        data: data,
        dataType: 'json'
      })
    }
  },
  computed: {
    title: function() {
      if(this.step == 1) {
        return 'New Card Sort'
      } else {
        return this.name
      }
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, Group, Card }
}
</script>