<template>
    <div class="py-6 border-b bg-orange-50 text-gray-900">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="lg:flex lg:items-center lg:justify-between">
          <div class="flex justify-between">
            <svg v-show="!report_private" class="flex-initial mr-1 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path d="M10 2a5 5 0 00-5 5v2a2 2 0 00-2 2v5a2 2 0 002 2h10a2 2 0 002-2v-5a2 2 0 00-2-2H7V7a3 3 0 015.905-.75 1 1 0 001.937-.5A5.002 5.002 0 0010 2z" />
            </svg>
            <svg v-show="report_private" class="mr-1 inline h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
            </svg>            
            <h5 v-show="!report_private" class="flex-1 text-sm mb-6 lg:mb-0">
              This report is public. It can be viewed by anyone with the link. <span v-if="!shared_report">(<a :href="edit_url" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)</span>
            </h5>
            <h5 v-show="report_private && !password_protect_report" class="flex-1 text-sm">
              This report is private. Only you can view it. <span v-if="!shared_report">(<a :href="edit_url" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)</span>
            </h5>              
            <h5 v-show="report_private && password_protect_report" class="flex-1 text-sm mb-6 lg:mb-0">
              This report is private. Only you and those with the password can view it. <span v-if="!shared_report">(<a :href="edit_url" class="text-purple-600 hover:text-purple-500 transition ease-in-out duration-150">Edit</a>)</span>
            </h5>            
          </div>
          <div class="md:flex md:items-center md:justify-between">
            <h5 class="text-sm mr-2 font-bold">Share:</h5>
            <div class="flex rounded-md shadow-sm w-full">
              <div class="relative flex-grow focus-within:z-10">
                <input class="form-input block w-full rounded-none rounded-l-md transition ease-in-out duration-150 sm:text-sm sm:leading-5" :value="report_url" />
              </div>
              <button v-clipboard:copy="report_url" class="-ml-px relative inline-flex items-center px-4 py-2 text-sm leading-5 font-medium rounded-r-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
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
    </div>  
</template>

<script>

export default {
  props: {
    report_private: Boolean, 
    password_protect_report: Boolean,
    report_url: String,
    edit_url: String,
    shared_report: Boolean
  }
}
</script>