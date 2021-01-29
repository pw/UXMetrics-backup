<template>
  <div>
    <Nav :title="title" :step="card_sort.creation_step" @back="back"/>
    <SetupSteps
    :current_step="card_sort.creation_step"
    :steps="['Study Setup', 'Add Cards', 'Advanced Options']" />
    <Step 
    v-show="card_sort.creation_step === 1"
    @next="create"
    instructions="Let's start with the basics to set up your study. Then we'll create your cards.">    
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextInput id="name" ref="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your study..." 
        v-model="card_sort.name"
        @input="saveProperty('name')"
        />
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with an introduction" 
        v-model="card_sort.participant_instructions"
        @input="saveProperty('participant_instructions')" 
        />
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" 
        v-model="card_sort.thank_you_message"
        @input="saveProperty('thank_you_message')" 
        />
      </div>       
    </Step>
    
    <Step v-show="card_sort.creation_step === 2" @next="completeStep2" instructions="Now let's choose your sort type and add your cards.">
      <div :class="{'mb-6 pb-6 border-b border-gray-100': (card_sort.sort_type === 'closed') || (card_sort.sort_type === 'hybrid')}">
        <SortType 
        v-model="card_sort.sort_type"
        @input="saveProperty('sort_type')"
        :enabled="true"
        />
      </div>
      <Groups 
      :value="groups"
      :card_sort_id="card_sort.id"
      v-show="(card_sort.sort_type === 'closed') || (card_sort.sort_type === 'hybrid')"
      />
      <Cards
      :value="cards"
      :card_sort_id="card_sort.id"
      />
    </Step>

    <Step 
    v-show="card_sort.creation_step === 3" 
    @next="completeStep3" 
    instructions="Enhance your study with some optional pro upgrades."
    >
      <ProBadge></ProBadge>
      <LogoUpload
      class="mb-6 pb-6 border-b border-gray-100"
      v-model="card_sort.logo_key"
      @input="saveProperty('logo_key')"
      instructions="Add custom branding to this study"
      :logo_base_url="card_sort.logo_base_url"
      :enabled="card_sort.subscribed"
      @attempt="openSubscribeModal"
      />
      <ProBadge></ProBadge>
      <Slider 
      class="mb-6 pb-6 border-b border-gray-100" 
      v-model="card_sort.randomize_card_order" 
      @input="saveProperty('randomize_card_order')" 
      :toggleable="card_sort.subscribed" 
      @attempt="openSubscribeModal"
      label="Randomize card order for each participant" description="This ensures that each card has a chance to be sorted earlier in the session" />
      <ProBadge></ProBadge>
      <Slider 
      class="mb-6" 
      :value="card_sort.subscribed" 
      :toggleable="false"
      @attempt="openSubscribeModal" 
      label="Advanced Report Sharing" 
      description="Your study results can be shared with an unlisted public URL by default" />
      <div class="relative flex items-start mb-6">
        <div class="flex items-center h-5">
          <input 
          v-model="card_sort.report_private"
          @change="saveProperty('report_private')"
          @click="preventDefaultUnlessSubscriberAndOpenModal"
          id="report_private" 
          name="report_private" 
          type="checkbox" 
          class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded">
        </div>
        <div class="ml-3 text-sm">
          <label for="report_private" class="font-medium text-gray-700">Keep my report private</label>
          <p class="text-gray-500">Disable public access to your results</p>
        </div>
      </div>
      <div class="relative flex items-start mb-6">
        <div class="flex items-center h-5">
          <input 
          v-model="card_sort.password_protect_report"
          @change="saveProperty('password_protect_report')"
          @click="preventDefaultUnlessSubscriberAndOpenModal"
          id="password_protect_report"
          name="password_protect_report" 
          type="checkbox" 
          class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded">
        </div>
        <div class="ml-3 text-sm">
          <label for="password_protect_report" class="font-medium text-gray-700">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="text-gray-700 h-4 w-4 inline">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>
            Add password protection
          </label>
          <p class="text-gray-500 mb-6">Securely share your study results with your team and clients</p>
          <TextInput 
          id="report_password" 
          ref="report_password" 
          label="Report Password" 
          instructions="Provide this to anyone you want to have access"           
          v-show="card_sort.password_protect_report"
          v-model="card_sort.report_password"
          @input="saveProperty('report_password')"
          />
        </div>
      </div>
    </Step>

    <Flash v-show="show_flash" v-model="show_flash" :notice="flash_notice">
    </Flash>
    <transition name="modal-component">
      <Subscribe
      v-show="subscribe_modal_open"
      @close="subscribe_modal_open = false"
      :show="subscribe_modal_open"
      :redirect_url="card_sort.edit_url"
      :user_id="card_sort.user_id"
      feature="card_sort"
      :feature_instance_id="card_sort.id"      
      />
    </transition>    
  </div>
</template>

<script>
import Nav from '../components/creation_nav.vue'
import Step from '../components/creation_step.vue'
import TextInput from '../components/text_input.vue'
import TextArea from '../components/text_area.vue'
import Flash from '../components/flash.vue'
import SaveAndContinue from '../components/creation_save_and_continue.vue'
import Groups from '../components/card_sort/groups.vue'
import Cards from '../components/card_sort/cards.vue'
import Slider from '../components/slider.vue'
import LogoUpload from '../components/logo_upload.vue'
import ProBadge from '../components/pro_badge.vue'
import SortType from '../components/sort_type_selector.vue'
import Subscribe from '../components/subscribe.vue'
import SetupSteps from '../components/study_setup_steps.vue'

import Rails from '@rails/ujs'

export default {
  props: {
    data: Object
  },
  data () {
    return {
      card_sort: this.data,
      groups: this.data.card_sort_groups.sort((a,b) => a.order - b.order),
      cards: this.data.card_sort_cards.sort((a,b) => a.order - b.order),
      show_flash: false,
      flash_notice: '',
      subscribe_modal_open: false
    }
  },
  methods: {
    completeStep2() {
      this.card_sort.creation_step += 1
      this.saveProperty('creation_step')
    },
    completeStep3() {
      this.card_sort.creation_wizard_complete = true
      var data = new FormData 
      data.append('card_sort[creation_wizard_complete]', this.card_sort.creation_wizard_complete)
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort.id,
        type: 'PATCH', 
        data: data,
        success: () => {
          window.location = this.card_sort.edit_url
        }
      })      
    },
    back: function() {
      this.card_sort.creation_step -= 1
    },
    create() {
      if(this.card_sort.name === '') {
        this.flash_notice = 'Name cannot be blank.'
        this.show_flash = true
        this.$refs.name.$refs.input.focus()      
        return
      } 
      if(!this.card_sort.id) {
        var data = new FormData
        data.append('card_sort[name]', this.card_sort.name)
        data.append('card_sort[participant_instructions]', this.card_sort.participant_instructions)
        data.append('card_sort[thank_you_message]', this.card_sort.thank_you_message)      
        Rails.ajax({
          url: '/card_sorts',
          type: 'POST', 
          data: data,
          dataType: 'json',
          success: (response) => {
            this.card_sort = response
            this.card_sort.creation_step += 1
            this.saveProperty('creation_step')
          }
        })  
      } else {
        this.card_sort.creation_step += 1          
      }
    }, 
    openSubscribeModal() {
      if(!this.card_sort.subscribed) {
        this.subscribe_modal_open = true
      }
    },
    preventDefaultUnlessSubscriberAndOpenModal(event) {
      if(!this.card_sort.subscribed) {
        event.preventDefault()  
        this.openSubscribeModal()    
      }
    },
    saveProperty(property) {
      if(this.card_sort.id) {
        var data = new FormData 
        data.append('card_sort[' + property + ']', this.card_sort[property])
        Rails.ajax({
          url: '/card_sorts/' + this.card_sort.id,
          type: 'PATCH', 
          data: data
        }) 
      }
    }     
  },
  computed: {
    title: function() {
      if(this.card_sort.name !== '') {
        return this.card_sort.name
      } else {
        return 'New Card Sort'
      }
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, Groups, Cards, Flash, SaveAndContinue, LogoUpload, ProBadge, SortType, Subscribe, SetupSteps }
}
</script>