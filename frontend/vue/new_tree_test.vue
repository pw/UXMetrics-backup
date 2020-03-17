<template>
  <div>
    <div>
      <div class="py-6 border-b">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="md:flex md:items-center md:justify-between">
            <div class="flex-1 min-w-0">

                <h1 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:leading-9 sm:truncate">
                  New Tree Test
                </h1>

            </div>
            <div class="mt-4 flex md:mt-0 md:ml-4">
              <span class="shadow-sm rounded-md" :class="{ hidden: (page == 1)}">
                <a @click="previousPage" class="back-btn inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:shadow-outline focus:border-blue-300 transition duration-150 ease-in-out">
                  <svg class="-ml-1 mr-2 h-5 w-5 text-gray-700" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M9.70711 16.7071C9.31658 17.0976 8.68342 17.0976 8.29289 16.7071L2.29289 10.7071C1.90237 10.3166 1.90237 9.68342 2.29289 9.29289L8.29289 3.29289C8.68342 2.90237 9.31658 2.90237 9.70711 3.29289C10.0976 3.68342 10.0976 4.31658 9.70711 4.70711L5.41421 9H17C17.5523 9 18 9.44772 18 10C18 10.5523 17.5523 11 17 11L5.41421 11L9.70711 15.2929C10.0976 15.6834 10.0976 16.3166 9.70711 16.7071Z"/>
                  </svg>
                  Back
                </a>
              </span>              
              <span class="sm:ml-3 shadow-sm rounded-md">
                  <a @click="nextPage" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out">
                      Save and Continue
                      <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                      </svg>
                  </a>
              </span>
            </div>
          </div>
        </div>
      </div>
      <main class="py-6" :class="{ hidden: page != 1 }">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-wrap">
            <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">
              <div class="mb-6 bg-indigo-100 border-l-4 border-indigo-500 text-indigo-700 p-4" role="alert">
              <p class="font-bold">Step 1 of 3</p>
              <p>Let's start with the basics. Then we'll create your tree and tasks.</p>
              <p class="mt-4 flex items-center">
                  <svg class="inline mr-1 h-6 w-6 text-indigo-700" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                  <path d="M9.66347 17H14.3364M11.9999 3V4M18.3639 5.63604L17.6568 6.34315M21 11.9999H20M4 11.9999H3M6.34309 6.34315L5.63599 5.63604M8.46441 15.5356C6.51179 13.5829 6.51179 10.4171 8.46441 8.46449C10.417 6.51187 13.5829 6.51187 15.5355 8.46449C17.4881 10.4171 17.4881 13.5829 15.5355 15.5356L14.9884 16.0827C14.3555 16.7155 13.9999 17.5739 13.9999 18.469V19C13.9999 20.1046 13.1045 21 11.9999 21C10.8954 21 9.99995 20.1046 9.99995 19V18.469C9.99995 17.5739 9.6444 16.7155 9.01151 16.0827L8.46441 15.5356Z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  <a href="#">
                  Show Tips
                  </a>
              </p>
              </div>
            </div>
            <div class="w-full md:w-2/3 xl:w-3/5">
              <form>
                  <div class="grid grid-cols-1 row-gap-6 col-gap-4 sm:grid-cols-6">
                      <div class="sm:col-span-4">
                          <label for="name" class="block text-sm font-medium leading-5 text-gray-700">Name</label>
                          <div class="mt-1 relative rounded-md shadow-sm">
                              <input id="name" class="form-input block w-full sm:text-sm sm:leading-5" placeholder="Add a descriptive name for your tree test..." v-model="name"/>
                          </div>
                      </div>
                      <div class="sm:col-span-4">
                          <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
                              Logo
                          </label>
                          <div class="mt-2 flex items-center">
                              <span class="rounded-md shadow-sm">
                                  <button type="button" class="py-2 px-3 border border-gray-300 rounded-md text-sm leading-4 font-medium text-gray-700 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-50 active:text-gray-800 transition duration-150 ease-in-out">
                                      Choose File
                                  </button>
                              </span>
                          </div>
                          <p class="mt-2 text-sm text-gray-500">Upload a custom logo for this tree test</p>
                      </div>
                      <div class="sm:col-span-4">
                          <label for="instructions" class="block text-sm font-medium leading-5 text-gray-700">
                              Participant Instructions
                          </label>
                          <div class="mt-1 rounded-md shadow-sm">
                              <textarea id="instructions" rows="3" class="form-textarea block w-full transition duration-150 ease-in-out sm:text-sm sm:leading-5" v-model="instructions">
                              </textarea>
                          </div>
                          <p class="mt-2 text-sm text-gray-500">Greet your tree test participants with a custom introduction</p>
                      </div>
                      <div class="sm:col-span-4">
                          <label for="thanks" class="block text-sm font-medium leading-5 text-gray-700">
                              Thank You Message
                          </label>
                          <div class="mt-1 rounded-md shadow-sm">
                              <textarea id="thanks" rows="3" class="form-textarea block w-full transition duration-150 ease-in-out sm:text-sm sm:leading-5" v-model="thank_you_message">
                              </textarea>
                          </div>
                          <p class="mt-2 text-sm text-gray-500">Custom thank you message to show participants upon completion</p>
                      </div>
                  </div>
              </form>
            </div>
          </div>
        </div>
      </main>

      <main class="py-6" :class="{ hidden: page != 2 }">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div class="flex flex-wrap">
            <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 mb-6">
              <div class="mb-6 bg-indigo-100 border-l-4 border-indigo-500 text-indigo-700 p-4" role="alert">
                <p class="font-bold">Step 2 of 3</p>
                <p>Now let's set up your tree.</p>
                <p class="mt-4 flex items-center">
                  <svg class="inline mr-1 h-6 w-6 text-indigo-700" stroke="currentColor" fill="none" viewBox="0 0 24 24">
                    <path d="M9.66347 17H14.3364M11.9999 3V4M18.3639 5.63604L17.6568 6.34315M21 11.9999H20M4 11.9999H3M6.34309 6.34315L5.63599 5.63604M8.46441 15.5356C6.51179 13.5829 6.51179 10.4171 8.46441 8.46449C10.417 6.51187 13.5829 6.51187 15.5355 8.46449C17.4881 10.4171 17.4881 13.5829 15.5355 15.5356L14.9884 16.0827C14.3555 16.7155 13.9999 17.5739 13.9999 18.469V19C13.9999 20.1046 13.1045 21 11.9999 21C10.8954 21 9.99995 20.1046 9.99995 19V18.469C9.99995 17.5739 9.6444 16.7155 9.01151 16.0827L8.46441 15.5356Z" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                  </svg>
                  <a href="#">
                    Show Tips
                  </a>
                </p>
              </div>
            </div>
            <div class="w-full md:w-2/3 xl:w-3/5">
              <div class="mb-6 flex items-center">
                <Slider label="Randomize tree order for participants"/>
              </div>
              <EditableTree :nodes="treeNodes"/>
            </div>
          </div>
        </div>
      </main>

    </div>
  </div>
</template>

<script>
import Slider from './components/slider.vue'
import EditableTree from './components/editable_tree.vue'
export default {
  data () {
    return {
      page: 1,
      name: undefined, 
      instructions: "Thank you for agreeing to help us, it shouldn't take more than 5 minutes!\n\nDon't worry, there is no right or wrong answer, just do what makes sense to you.",
      thank_you_message: "Thanks for taking the time to help us.\n\nYour contribution is essential in our journey to deliver improvements.",
      treeNodes: [
        { placeholder_text: 'Home' },
        { placeholder_text: 'Child' },
        { placeholder_text: 'Child of Child' }
      ]
    }
  },
  methods: {
    nextPage() {
      this.page += 1
    },
    previousPage() {
      this.page -= 1
    }
  },
  components: { Slider, EditableTree }
}
</script>
