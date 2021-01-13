<template>
  <div>
    <Nav :title="title" :step="tree_test.creation_step" @back="back"/>
    <SetupSteps
    :current_step="tree_test.creation_step"
    :steps="['Study Setup', 'Add Tree', 'Create Tasks', 'Advanced Options']"
    />
    <Step 
    v-show="tree_test.creation_step === 1"
    @next="create" 
    instructions="Let's start with the basics. Then we'll create your tree and tasks.">
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextInput 
        id="name" 
        ref="name"
        label="Name" 
        instructions="This won't be visible to your participants" 
        placeholder="Add a descriptive name for your study..." 
        v-model="tree_test.name"
        @input="saveProperty('name')"
        />
      </div>
      <div class="mb-6 pb-6 border-b border-gray-100">
        <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with an introduction" 
        v-model="tree_test.participant_instructions" 
        @input="saveProperty('participant_instructions')"
        />
      </div>
      <div>
        <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" 
        v-model="tree_test.thank_you_message"
        @input="saveProperty('thank_you_message')" />
      </div>
    </Step>

    <Step 
    v-show="tree_test.creation_step === 2" 
    @next="next"
    instructions="Now let's set up a tree representing your information architecture.">
      <Tree 
      v-model="tree_test.tree"
      :tree_test_id="tree_test.id"
      />
    </Step>
   
    <Step 
    v-show="tree_test.creation_step === 3" 
    @next="next"
    instructions="Finally, let's define the tasks you want participants to complete, and set the correct choice(s) for each.">  
      <Tasks
        v-model="tree_test.tree_test_tasks"
        :tree_test_id="tree_test.id"
        :json_tree="tree_test.tree"
      />      
    </Step>   

    <Step 
    v-show="tree_test.creation_step === 4" 
    @next="finish"
    instructions="Enhance your study with some optional pro upgrades."
    >
      <ProBadge></ProBadge>
      <LogoUpload
      class="mb-6 pb-6 border-b border-gray-100"
      v-model="tree_test.logo_key"
      @input="saveProperty('logo_key')"
      instructions="Add custom branding to this study"
      :logo_base_url="tree_test.logo_base_url"
      :enabled="tree_test.subscribed"
      @attempt="subscribe_modal_open = true"
      />   
      <ProBadge></ProBadge>
      <Slider 
      class="mb-6 pb-6 border-b border-gray-100"
      v-model="tree_test.randomize_task_order"
      @input="saveProperty('randomize_task_order')"
      :toggleable="tree_test.subscribed"
      @attempt="openSubscribeModal"
      label="Randomize task order for participants" description="This ensures that each task has a chance to be presented earlier in the session" />
      <ProBadge></ProBadge>
      <Slider 
      class="mb-6" 
      :value="tree_test.subscribed" 
      :toggleable="false"
      @attempt="openSubscribeModal" 
      label="Advanced Report Sharing" 
      description="Your study results can be shared with an unlisted public URL by default" />
      <div class="relative flex items-start mb-6">
        <div class="flex items-center h-5">
          <input 
          v-model="tree_test.report_private"
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
          v-model="tree_test.password_protect_report"
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
          v-show="tree_test.password_protect_report"
          v-model="tree_test.report_password"
          @input="saveProperty('report_password')"
          />
        </div>
      </div>          
    </Step>

    <Flash v-show="show_flash" :show="show_flash" :notice="flash_notice">
    </Flash>
    <transition name="modal-component">
      <Subscribe
      v-show="subscribe_modal_open"
      @close="subscribe_modal_open = false"
      :show="subscribe_modal_open"
      :redirect_url="tree_test.edit_url"
      :user_id="tree_test.user_id"
      feature="tree_test"
      :feature_instance_id="tree_test.id"      
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
import Rails from '@rails/ujs'
import SetupSteps from '../components/study_setup_steps.vue'
import Subscribe from '../components/subscribe.vue'
import Tree from '../components/tree_test/tree.vue'
import Tasks from '../components/tree_test/tasks.vue'
import Slider from '../components/slider.vue'
import ProBadge from '../components/pro_badge.vue'
import LogoUpload from '../components/logo_upload.vue'

export default {
  props: {
    data: Object
  },  
  data () {
    return {
      tree_test: this.data,
      show_flash: false, 
      flash_notice: '',
      subscribe_modal_open: false,      
    }
  },
  methods: {
    saveProperty(property) {
      if(this.tree_test.id) {
        var data = new FormData 
        data.append('tree_test[' + property + ']', this.tree_test[property])
        Rails.ajax({
          url: '/tree_tests/' + this.tree_test.id,
          type: 'PATCH', 
          data: data
        }) 
      }
    },  
    next() {
      this.tree_test.creation_step += 1
      this.saveProperty('creation_step')
    },
    back() {
      this.tree_test.creation_step -= 1
    }, 
    finish() {
      this.tree_test.creation_wizard_complete = true
      var data = new FormData 
      data.append('tree_test[creation_wizard_complete]', this.tree_test.creation_wizard_complete)
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data,
        success: () => {
          window.location = this.tree_test.edit_url
        }
      })
    },  
    showFlash: function() {
      this.show_flash = true
      setTimeout(() => this.show_flash = false, 5000)
    },  
    openSubscribeModal() {
      if(!this.tree_test.subscribed) {
        this.subscribe_modal_open = true
      }
    },  
    preventDefaultUnlessSubscriberAndOpenModal(event) {
      if(!this.tree_test.subscribed) {
        event.preventDefault()  
        this.openSubscribeModal()    
      }
    },      
    create() {
      if(this.tree_test.name === '') {
        this.flash_notice = 'Name cannot be blank'
        this.showFlash()
        this.$refs.name.$refs.input.focus()      
        return
      } 
      if(!this.tree_test.id) {
        var data = new FormData
        data.append('tree_test[name]', this.tree_test.name)
        data.append('tree_test[participant_instructions]', this.tree_test.participant_instructions)
        data.append('tree_test[thank_you_message]', this.tree_test.thank_you_message)      
        Rails.ajax({
          url: '/tree_tests',
          type: 'POST', 
          data: data,
          dataType: 'json',
          success: (response) => {
            this.tree_test = response
            this.tree_test.creation_step += 1
            this.saveProperty('creation_step')
          }
        })  
      } else {
        this.tree_test.creation_step += 1          
      }
    }
  },
  computed: {
    title: function() {
      if(this.tree_test.name !== '') {
        return this.tree_test.name
      } else {
        return 'New Tree Test'
      }
    }
  },
  components: { Nav, Step, TextInput, TextArea, Slider, Flash, SetupSteps, Subscribe, Tree, Tasks, ProBadge, LogoUpload }
}
</script>