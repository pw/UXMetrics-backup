<template>
  <div>
    <Nav :name="card_sort.name" :created_at="card_sort.created_at_day" :status="card_sort.status" />

    <main class="py-6">   
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex flex-wrap">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">

            <div v-show="card_sort.status == 'draft'" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 class="text-lg leading-6 font-medium text-gray-900">
                  Your card sort has been created!
                </h3>
                <p class="text-sm text-center py-2 mb-4">Ready to publish? Just hit the button below.</p>
                <button @click="publish" class="block w-full text-center px-6 py-3 rounded-md shadow-sm cursor-pointer border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700  focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
                  Publish
                </button>
              </div>
            </div>

            <div v-show="card_sort.status == 'published' && card_sort.results_count == 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <p class="text-sm text-center py-2">
                  We'll email when you get your first result.
                </p>
              </div>
            </div>     

            <div v-show="card_sort.status == 'published' && card_sort.results_count != 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 v-if="card_sort.results_count == 1" class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  1 Test Result
                </h3>
                <h3 v-else class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  {{ card_sort.results_count }} Test Results
                </h3>                
                <div class="fields-inline items-end">
                  <a class="block w-full text-center px-6 py-3 rounded-md shadow-sm border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150" :href="'/card_sorts/' + card_sort.id + '/report'">
                    View Report
                  </a>                
                </div>
              </div>
            </div>

            <div v-show="card_sort.status == 'ended'" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 v-if="card_sort.results_count == 1" class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  1 Test Result
                </h3>
                <h3 v-else class="text-lg leading-6 font-medium text-gray-900 mb-4">
                  {{ card_sort.results_count }} Test Results
                </h3>                
                <div class="fields-inline items-end">
                  <a class="block w-full text-center px-6 py-3 rounded-md shadow-sm border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150" :href="'/card_sorts/' + card_sort.id + '/report'">
                    View Report
                  </a>                
                </div>
              </div>
            </div>            

            <div v-show="card_sort.status == 'published'" class="bg-white shadow sm:rounded-lg text-center mb-6">
              <div class="px-4 py-5 sm:p-6">
                <h3 class="text-lg leading-6 font-medium text-gray-900">
                  Your card sort is <span class="text-green-500">published</span>.
                </h3>

                <p class="text-sm text-center py-2 mb-4">
                  Copy the link below to share with participants.
                </p>

                <div>
                  <div class="mt-1 flex rounded-md shadow-sm">
                    <div class="relative flex-grow focus-within:z-10">
                      <input id="email" class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" :value="card_sort.collect_url" />
                    </div>
                    <button v-clipboard:copy="card_sort.collect_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
                      <svg class="h-5 w-5 text-white" viewBox="0 0 20 20" fill="currentColor">
                        <path d="M9 2C7.89543 2 7 2.89543 7 4V12C7 13.1046 7.89543 14 9 14H15C16.1046 14 17 13.1046 17 12V6.41421C17 5.88378 16.7893 5.37507 16.4142 5L14 2.58579C13.6249 2.21071 13.1162 2 12.5858 2H9Z"/>
                        <path d="M3 8C3 6.89543 3.89543 6 5 6V16H13C13 17.1046 12.1046 18 11 18H5C3.89543 18 3 17.1046 3 16V8Z"/>
                      </svg>
                      <span class="ml-2">Copy</span>
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div class="bg-gray-200 overflow-hidden rounded-lg mb-6 text-center">
              <div class="px-4 py-5 sm:p-6">
                <a @click="endStudy" v-show="card_sort.status == 'published'" class="end-t mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md shadow-sm text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150 cursor-pointer">End This Test</a>   

                <p v-show="card_sort.status == 'ended'" class="mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-gray-200">This test has been ended.</p>                       
                <p class="text-sm">
                  Need to <a @click="deleteStudy" class="text-red-700 underline cursor-pointer">delete</a> this study?
                </p>
              </div>
            </div>
          </div>  

          <div class="w-full md:w-2/3 xl:w-3/5">
            <div class="shadow sm:rounded-md sm:overflow-hidden">
              <div class="px-4 py-5 bg-white sm:p-6">
                <div class="bg-purple-50 sm:rounded-lg mb-6">
                  <div class="px-4 py-5 sm:p-6">
                    <h3 class="text-lg leading-6 font-medium text-gray-900">
                      Participant Preview
                    </h3>
                    <div class="mt-2 sm:flex sm:items-start sm:justify-between">
                      <div class="max-w-xl text-sm leading-5 text-gray-500">
                        <p>
                          Test drive your study exactly as your participants will experience it.
                        </p>
                      </div>
                      <div class="mt-5 sm:mt-0 sm:ml-6 sm:flex-shrink-0 sm:flex sm:items-center">
                        <span class="shadow-sm rounded-md">
                          <a :href="card_sort.collect_url + '?preview=true'" target="_blank" class="preview-btn inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                            <svg class="-ml-1 mr-2 h-5 w-5 text-gray-700" fill="currentColor" viewBox="0 0 20 20">
                              <path d="M10 12C11.1046 12 12 11.1046 12 10C12 8.89543 11.1046 8 10 8C8.89544 8 8.00001 8.89543 8.00001 10C8.00001 11.1046 8.89544 12 10 12Z"/>
                              <path fill-rule="evenodd" clip-rule="evenodd" d="M0.457764 10C1.73202 5.94291 5.52232 3 9.99997 3C14.4776 3 18.2679 5.94288 19.5422 9.99996C18.2679 14.0571 14.4776 17 9.99995 17C5.52232 17 1.73204 14.0571 0.457764 10ZM14 10C14 12.2091 12.2091 14 10 14C7.79087 14 6.00001 12.2091 6.00001 10C6.00001 7.79086 7.79087 6 10 6C12.2091 6 14 7.79086 14 10Z"/>
                            </svg>
                            Preview
                          </a>
                        </span>
                      </div>
                    </div>
                  </div>
                </div>

                <div>
                  <div class="mb-6">
                    <div class="block">
                      <div class="border-b border-gray-200 text-gray-500">
                        <nav class="-mb-px flex">
                          <button 
                            @click="tab = 'settings'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'settings' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Settings
                          </button>
                          <button 
                            @click="tab = 'cards'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'cards' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Cards
                          </button>
                          <button 
                            @click="tab = 'pro'"
                            :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'pro' }"
                            class="w-1/3 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                            Pro
                          </button>                          
                        </nav>
                      </div>
                    </div>
                  </div>              
                </div>

                <div v-show="tab === 'settings'">
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

                <div v-show="tab === 'cards'">  
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

                <div v-show="tab === 'pro'">
                  <LogoUpload
                  class="mb-6 pb-6 border-b border-gray-100"
                  v-model="card_sort.logo_key"
                  @input="saveProperty('logo_key')"
                  instructions="Add custom branding to this study"
                  :logo_base_url="card_sort.logo_base_url"
                  :enabled="card_sort.subscribed"
                  @attempt="subscribe_modal_open = true"
                  />
                  <Slider 
                  class="mb-6 pb-6 border-b border-gray-100" 
                  v-model="card_sort.randomize_card_order" 
                  @input="saveProperty('randomize_card_order')" 
                  :toggleable="card_sort.subscribed" 
                  @attempt="openSubscribeModal"
                  label="Randomize card order for each participant" description="This ensures that each card has a chance to be sorted earlier in the session" />
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

export default {
  props: {
    data: {
      type: Object
    }
  },
  data () {
    return {
      card_sort: this.data,
      tab: 'settings',
      groups: this.data.card_sort_groups.sort((a,b) => a.order - b.order),
      cards: this.data.card_sort_cards.sort((a,b) => a.order - b.order),
      subscribe_modal_open: false
    }
  },  
  methods: {
    publish() {
      var r = confirm('Are you sure?')
      if(r == true) {
        var data = new FormData 
        data.append('card_sort[status]', 'published')
        Rails.ajax({
          url: '/card_sorts/' + this.card_sort.id,
          type: 'PATCH', 
          data: data,
          success: () => {
            this.card_sort.status = 'published'
          } 
        })        
      }
    },
    deleteStudy() {
      var r = confirm('Are you sure?')
      if(r == true) {
        Rails.ajax({
          url: '/card_sorts/' + this.card_sort.id,
          type: 'DELETE'
        })
      }
    },
    endStudy() {
      var r = confirm('Are you sure?')
      if(r == true) {
        var data = new FormData 
        data.append('card_sort[status]', 'ended')
        Rails.ajax({
          url: '/card_sorts/' + this.card_sort.id,
          type: 'PATCH', 
          data: data,
          success: () => {
            this.card_sort.status = 'ended'
          }
        })        
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
  components: { Nav, Subscribe, TextInput, TextArea, Slider, Groups, Cards, LogoUpload, SortType }
}
</script>