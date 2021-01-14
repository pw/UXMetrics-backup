<template>
  <div>
    <Nav :name="card_sort.name" :created_at="card_sort.created_at_day" :status="card_sort.status" />

    <main class="py-6">   
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap">
          <Sidebar
            study_type="card sort"
            :study_id="card_sort.id"
            :status="card_sort.status"
            :results_count="card_sort.results_count"
            :report_url="'/card_sorts/' + card_sort.id + '/report'"
            :collect_url="card_sort.collect_url"
            @published="card_sort.status = 'published'"
            @ended="card_sort.status = 'ended'"
          />  
          <div class="w-full md:w-2/3 xl:w-3/5">
            <div class="shadow sm:rounded-md sm:overflow-hidden">
              <div class="px-4 py-5 bg-white sm:p-6">
                <ParticipantPreview
                  :url="card_sort.collect_url + '?preview=true'"
                />                                

                <Tabs
                  :tabs="['Settings', 'Cards', 'Pro']"
                  :current_tab="tab"
                  @changeTab="changeTab"
                />

                <div v-show="tab === 'Settings'">
                  <div class="mb-6 pb-6 border-b border-gray-100">
                    <TextInput id="name" label="Name" instructions="This won't be visible to your participants" placeholder="Add a descriptive name for your card sort..." v-model="card_sort.name" @blur="saveProperty('name')" :disabled="card_sort.status != 'draft'" />
                  </div>
                  <div class="mb-6 pb-6 border-b border-gray-100">
                    <TextArea id="instructions" label="Participant Instructions" instructions="Greet your participants with a custom introduction" :disabled="card_sort.status != 'draft'" v-model="card_sort.participant_instructions" @blur="saveProperty('participant_instructions')" />
                  </div>
                  <div class="">
                    <TextArea id="thanks" label="Thank You Message" instructions="Your participants will see this when they complete the study" :disabled="card_sort.status != 'draft'" v-model="card_sort.thank_you_message" @blur="saveProperty('thank_you_message')"/>
                  </div>            
                </div>

                <div v-show="tab === 'Cards'">  
                  <SortType
                  v-model="card_sort.sort_type"
                  @input="saveProperty('sort_type')"
                  :enabled="card_sort.status === 'draft'"
                  />            
                  <Groups 
                  :value="groups"
                  :card_sort_id="card_sort.id"
                  v-show="(card_sort.sort_type === 'closed') || (card_sort.sort_type === 'hybrid')"
                  :enabled="card_sort.status === 'draft'"
                  />
                  <Cards
                  :value="cards"
                  :card_sort_id="card_sort.id"
                  :enabled="card_sort.status === 'draft'"
                  />                     
                </div>

                <div v-show="tab === 'Pro'">
                  <ProBadge></ProBadge>
                  <LogoUpload
                  class="mb-6 pb-6 border-b border-gray-100"
                  v-model="card_sort.logo_key"
                  @input="saveProperty('logo_key')"
                  instructions="Add custom branding to this study"
                  :logo_base_url="card_sort.logo_base_url"
                  :enabled="card_sort.subscribed"
                  @attempt="subscribe_modal_open = true"
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
                      <p class="text-gray-500">Your results will not be available for sharing publicly</p>
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
      :redirect_url="card_sort.edit_url"
      :user_id="card_sort.user_id"
      feature="card_sort"
      :feature_instance_id="card_sort.id"
      />
    </transition>
  </div>
</template>

<script>
import Nav from '../components/edit_tree_test/nav.vue'
import Subscribe from '../components/subscribe.vue'
import Rails from '@rails/ujs'

import TextInput from '../components/text_input.vue'
import TextArea from '../components/text_area.vue'
import Slider from '../components/slider.vue'
import Groups from '../components/card_sort/groups.vue'
import Cards from '../components/card_sort/cards.vue'
import LogoUpload from '../components/logo_upload.vue'
import SortType from '../components/sort_type_selector.vue'
import Sidebar from '../components/edit_sidebar.vue'
import Tabs from '../components/tabs.vue'
import ProBadge from '../components/pro_badge.vue'
import ParticipantPreview from '../components/participant_preview.vue'

export default {
  props: {
    data: {
      type: Object
    }
  },
  data () {
    return {
      card_sort: this.data,
      tab: 'Settings',
      groups: this.data.card_sort_groups.sort((a,b) => a.order - b.order),
      cards: this.data.card_sort_cards.sort((a,b) => a.order - b.order),
      subscribe_modal_open: false
    }
  },  
  methods: {
    changeTab(name) {
      this.tab = name
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
      if(this.card_sort.status !== 'draft') { return }
      var data = new FormData 
      data.append('card_sort[' + property + ']', this.card_sort[property])
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort.id,
        type: 'PATCH', 
        data: data
      }) 
    } 
  },
  components: { Nav, Subscribe, TextInput, TextArea, Slider, Groups, Cards, LogoUpload, SortType, Sidebar, Tabs, ProBadge, ParticipantPreview }
}
</script>