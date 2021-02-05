<template>
  <main class="py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="bg-white sm:rounded-lg shadow mb-6">
        <div class="px-4 py-5 sm:p-6">
          <img :src="logo_url" class="mb-6 w-40">
          <h3 class="text-xl leading-6 font-medium text-gray-900 mb-4">
            {{ heading }}
          </h3> 
          <slot></slot>
          <div v-show="show_button" class="mt-5">
            <span class="shadow-sm rounded-md">
              <a @click="$emit('buttonClick')" class="inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-green-500 hover:bg-green-400 focus:outline-none focus:shadow-outline-green focus:border-green-600 transition duration-150 ease-in-out cursor-pointer">
                {{ button_label }}
                <svg class="ml-3 -mr-1 h-5 w-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" clip-rule="evenodd" d="M10.2929 3.29289C10.6834 2.90237 11.3166 2.90237 11.7071 3.29289L17.7071 9.29289C18.0976 9.68342 18.0976 10.3166 17.7071 10.7071L11.7071 16.7071C11.3166 17.0976 10.6834 17.0976 10.2929 16.7071C9.90237 16.3166 9.90237 15.6834 10.2929 15.2929L14.5858 11L3 11C2.44772 11 2 10.5523 2 10C2 9.44772 2.44772 9 3 9H14.5858L10.2929 4.70711C9.90237 4.31658 9.90237 3.68342 10.2929 3.29289Z"/>
                </svg>
              </a>
            </span>
          </div>
        </div>
      </div>
    </div>
  </main> 
</template>

<script>
  export default {
    props: {
      logo_url: String,
      heading: String,
      button_label: String,
      show_button: {
        type: Boolean,
        default: true
      }
    }
  }
</script>