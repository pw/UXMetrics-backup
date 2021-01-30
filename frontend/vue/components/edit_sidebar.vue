<template>
  <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">

    <div v-show="study.status === 'draft'" class="bg-white shadow sm:rounded-lg text-center mb-6">
      <div class="px-4 py-5 sm:p-6">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          Your {{ study_type }} has been created!
        </h3>
        <p class="text-sm text-center py-2 mb-4">Ready to publish? Just hit the button below.</p>
        <button @click="publish" class="block w-full text-center px-6 py-3 rounded-md shadow-sm cursor-pointer border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700  focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
          Publish
        </button>
      </div>
    </div>

    <div v-show="study.status === 'published' && study.results_count === 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
      <div class="px-4 py-5 sm:p-6">
        <p class="text-sm text-center py-2">
          We'll email when you get your first result.
        </p>
      </div>
    </div>     

    <div v-show="study.status === 'published' && study.results_count !== 0" class="bg-white shadow sm:rounded-lg text-center mb-6">
      <div class="px-4 py-5 sm:p-6">
        <h3 v-if="study.results_count === 1" class="text-lg leading-6 font-medium text-gray-900 mb-4">
          1 Test Result
        </h3>
        <h3 v-else class="text-lg leading-6 font-medium text-gray-900 mb-4">
          {{ study.results_count }} Test Results
        </h3>                
        <div class="fields-inline items-end">
          <a class="block w-full text-center px-6 py-3 rounded-md shadow-sm border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150" :href="study.report_url">
            View Report
          </a>                
        </div>
      </div>
    </div>

    <div v-show="study.status === 'ended'" class="bg-white shadow sm:rounded-lg text-center mb-6">
      <div class="px-4 py-5 sm:p-6">
        <h3 v-if="study.results_count === 1" class="text-lg leading-6 font-medium text-gray-900 mb-4">
          1 Test Result
        </h3>
        <h3 v-else class="text-lg leading-6 font-medium text-gray-900 mb-4">
          {{ study.results_count }} Test Results
        </h3>                
        <div class="fields-inline items-end">
          <a class="block w-full text-center px-6 py-3 rounded-md shadow-sm border border-transparent text-base leading-6 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150" :href="study.report_url">
            View Report
          </a>                
        </div>
      </div>
    </div>            

    <div v-show="study.status === 'published'" class="bg-white shadow sm:rounded-lg text-center mb-6">
      <div class="px-4 py-5 sm:p-6">
        <h3 class="text-lg leading-6 font-medium text-gray-900">
          Your {{ study_type }} is <span class="text-green-500">published</span>.
        </h3>

        <p class="text-sm text-center py-2 mb-4">
          Copy the link below to share with participants.
        </p>

        <div>
          <div class="mt-1 flex rounded-md shadow-sm">
            <div class="relative flex-grow focus-within:z-10">
              <input id="email" class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" :value="study.collect_url" />
            </div>
            <button v-clipboard:copy="study.collect_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
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
        <a @click="endStudy" v-show="study.status === 'published'" class="end-t mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md shadow-sm text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150 cursor-pointer">End This Test</a>   

        <p v-show="study.status === 'ended'" class="mb-6 block text-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-gray-200">This test has been ended.</p>                       
        <p class="text-sm">
          Need to <a @click="deleteStudy" class="text-red-700 underline cursor-pointer">delete</a> this study?
        </p>
      </div>
    </div>
  </div>

</template>

<script>
import Rails from '@rails/ujs'

export default {
  props: {
    study_type: String,
    study: Object
  },
  methods: {
    publish() {
      if(this.study_type === 'tree test') {
        this.$emit('publish')
      } else {
        var r = confirm('Are you sure?')
        if(r == true) {
          var data = new FormData 
          data.append(`${ this.study_type.replace(' ', '_') }[status]`, 'published')
          Rails.ajax({
            url: `/${ this.study_type.replace(' ', '_') }s/${ this.study.id }`,
            type: 'PATCH', 
            data: data,
            success: () => {
              this.$emit('published')
            } 
          })        
        }
      }
    }, 
    endStudy() {
      var r = confirm('Are you sure?')
      if(r == true) {
        var data = new FormData 
        data.append(`${ this.study_type.replace(' ', '_') }[status]`, 'ended')        
        Rails.ajax({
          url: `/${ this.study_type.replace(' ', '_') }s/${ this.study.id }`,
          type: 'PATCH', 
          data: data,
          success: () => {
            this.$emit('ended')
          }
        })        
      }      
    },  
    deleteStudy() {
      var r = confirm('Are you sure?')
      if(r == true) {
        Rails.ajax({
          url: `/${ this.study_type.replace(' ', '_') }s/${ this.study.id }`,
          type: 'DELETE'
        })
      }
    }          
  }
}
</script>