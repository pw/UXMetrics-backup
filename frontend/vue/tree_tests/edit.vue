<template>
  <div>
    <Nav :name="tree_test.name" :created_at="tree_test.created_at_day" :status="tree_test.status" />

    <main class="py-6">   
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap">
          <Sidebar
            study_type="tree test"
            :study="tree_test"
            @publish="publish"
            @ended="tree_test.status = 'ended'"            
          />
          <div class="w-full md:w-2/3 xl:w-3/5">
            <div class="shadow sm:rounded-md sm:overflow-hidden">
              <div class="px-4 py-5 bg-white sm:p-6">
                <ParticipantPreview
                  :url="tree_test.collect_url + '?preview=true'"
                />

                <Tabs
                  :tabs="['Settings', 'Tree', 'Tasks', 'Pro']"
                  :current_tab="tab"
                  @changeTab="changeTab"
                />

                <div v-show="tab == 'Settings'">
                  <form>
                    <div class="mb-6 pb-6 border-b border-gray-100">
                      <TextInput 
                      id="name" 
                      label="Name" 
                      instructions="This won't be visible to your participants"
                      placeholder="Add a descriptive name for your tree test..."
                      v-model="tree_test.name" 
                      @blur="saveProperty('name')" 
                      :disabled="tree_test.status !== 'draft'" />
                    </div>
                    <div class="mb-6 pb-6 border-b border-gray-100">
                      <TextArea 
                      id="instructions" 
                      label="Participant Instructions"
                      instructions="Greet your participants with a custom introduction" 
                      :disabled="tree_test.status !== 'draft'" 
                      v-model="tree_test.participant_instructions" 
                      @blur="saveProperty('participant_instructions')" />
                    </div>
                    <div class="">
                      <TextArea 
                      id="thanks" 
                      label="Thank You Message"
                      instructions="Your participants will see this when they complete the study" 
                      :disabled="tree_test.status !== 'draft'" 
                      v-model="tree_test.thank_you_message" 
                      @blur="saveProperty('thank_you_message')"/>
                    </div>
                  </form>              
                </div>

                <div v-show="tab == 'Tree'">       
                  <Tree 
                    v-model="tree_test.tree"
                    :tree_test_id="tree_test.id"
                    :disabled="tree_test.status !== 'draft'"
                  />
                </div>

                <div v-show="tab == 'Tasks'">
                  <Tasks
                    v-model="tree_test.tree_test_tasks"
                    :tree_test_id="tree_test.id"
                    :json_tree="tree_test.tree"
                    :disabled="tree_test.status !== 'draft'"
                  />                    
                </div>

                <div v-show="tab == 'Pro'">
                  <ProBadge></ProBadge>
                  <LogoUpload
                  class="mb-6 pb-6 border-b border-gray-100"
                  v-model="tree_test.logo_key"
                  @input="saveProperty('logo_key')"
                  instructions="Add custom branding to this study"
                  :logo_base_url="tree_test.logo_base_url"
                  :allowed="tree_test.subscribed"
                  @attempt="subscribe_modal_open = true"
                  />   
                  <ProBadge></ProBadge>
                  <Slider 
                  class="mb-6 pb-6 border-b border-gray-100"
                  v-model="tree_test.randomize_task_order"
                  @input="saveProperty('randomize_task_order')"
                  :toggleable="tree_test.subscribed && (tree_test.status === 'draft')"
                  @attempt="attemptOnUnallowedAndPublicationRestrictedFeature"
                  label="Randomize task order for participants" description="This ensures that each task has a chance to be presented earlier in the session" />
                  <ProBadge></ProBadge>
                  <Slider 
                  class="mb-6 pb-6 border-b border-gray-100"
                  v-model="tree_test.allow_skip"
                  @input="saveProperty('allow_skip')"
                  :toggleable="tree_test.subscribed && (tree_test.status === 'draft')"
                  @attempt="attemptOnUnallowedAndPublicationRestrictedFeature"
                  label="Allow participants to skip tasks if they get stuck" description="This can reduce abandonment rates and skips are tracked for you" />
                  <ProBadge></ProBadge>
                  <Slider 
                  class="mb-6" 
                  :value="tree_test.subscribed" 
                  :toggleable="false"
                  @attempt="attemptOnLockedFeature" 
                  label="Advanced Report Sharing" 
                  description="Your study results can be shared with an unlisted public URL by default" />
                  <div class="relative flex items-start mb-6">
                    <div class="flex items-center h-5">
                      <input 
                      v-model="tree_test.report_private"
                      @change="saveProperty('report_private')"
                      @click="preventDefaultAndOpenSubscribeModalUnlessSubscribed"
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
                      :disabled="tree_test.subscribed ? (tree_test.report_private ? false : true) : false"
                      @change="saveProperty('password_protect_report')"
                      @click="preventDefaultAndOpenSubscribeModalUnlessSubscribed"
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
                      @blur="saveProperty('report_password')"
                      />
                    </div>
                  </div>                           
                </div>

              </div>
            </div>
          </div>
        </div>
      </div> 
    </main>

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
    <Flash v-show="show_flash" :show="show_flash" :notice="flash_notice">
    </Flash>     
  </div>
</template>

<script>
import Nav from '../components/edit_tree_test/nav.vue'
import Subscribe from '../components/subscribe.vue'
import Rails from '@rails/ujs'

import TextInput from '../components/text_input.vue'
import TextArea from '../components/text_area.vue'
import Slider from '../components/slider.vue'
import Tabs from '../components/tabs.vue'
import ProBadge from '../components/pro_badge.vue'
import ParticipantPreview from '../components/participant_preview.vue'
import Tree from '../components/tree_test/tree.vue'
import Tasks from '../components/tree_test/tasks.vue'
import Sidebar from '../components/edit_sidebar.vue'
import LogoUpload from '../components/logo_upload.vue'
import Flash from '../components/flash.vue'

export default {
  props: {
    data: Object,
    starting_tab: String
  },
  data () {
    return {
      tree_test: this.data,
      tab: this.starting_tab,
      subscribe_modal_open: false,
      show_flash: false,
      flash_notice: ''   
    }
  },    
  methods: {  
    changeTab(name) {
      this.tab = name
    },    
    saveProperty(property) {
      if(this.tree_test.status !== 'draft' && !['logo_key', 'report_private', 'password_protect_report', 'report_password'].includes(property)) { return }      
      var data = new FormData 
      data.append('tree_test[' + property + ']', this.tree_test[property])
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test.id,
        type: 'PATCH', 
        data: data
      }) 
    },
    publish() {
      if(this.tree_test.tree_test_tasks.some(task => task.instructions === '')) {
        this.flash_notice = "Please include instructions for all tasks."
        this.show_flash = true        
      } else if(this.tree_test.tree_test_tasks.some(task => task.tree_test_task_correct_choices.length === 0)) {
        this.flash_notice = "Please set correct choice(s) for all tasks."
        this.show_flash = true 
      } else {
        var r = confirm('Are you sure?')
        if(r == true) {
          var data = new FormData 
          data.append('tree_test[status]', 'published')
          Rails.ajax({
            url: `/tree_tests/${ this.tree_test.id }`,
            type: 'PATCH', 
            data: data,
            success: () => {
              this.tree_test.status = 'published'
            } 
          })        
        }
      }
    },    
    attemptOnUnallowedAndPublicationRestrictedFeature() {
      if(this.tree_test.status === 'draft') {
        this.subscribe_modal_open = true
      } else {
        this.flash_notice = "This feature can't be changed after a study is published because it would impact the integrity of your results."
        this.show_flash = true
      }
    },
    attemptOnLockedFeature() {
      if(!this.tree_test.subscribed){
        this.subscribe_modal_open = true  
      }
    }, 
    preventDefaultAndOpenSubscribeModalUnlessSubscribed(event) {
      if(!this.tree_test.subscribed) {
        event.preventDefault()  
        this.subscribe_modal_open = true   
      }
    }    
  },
  components: { Nav, Subscribe, TextInput, TextArea, Slider, Tabs, ProBadge, ParticipantPreview, Tree, Tasks, Sidebar, LogoUpload, Flash }
}
</script>