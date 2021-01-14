<template>
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
            <a :href="url" target="_blank" class="preview-btn inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
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
</template>

<script>
export default {
  props: {
    url: String
  }
}
</script>