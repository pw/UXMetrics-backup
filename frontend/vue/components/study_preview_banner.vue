<template>
  <div class="bg-orange-100 text-orange-800 text-center py-6">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="inline-flex items-center">
        <svg class="-ml-1 mr-2 h-5 w-5 text-orange-800" fill="currentColor" viewBox="0 0 20 20">
          <path d="M10 12C11.1046 12 12 11.1046 12 10C12 8.89543 11.1046 8 10 8C8.89544 8 8.00001 8.89543 8.00001 10C8.00001 11.1046 8.89544 12 10 12Z"/>
          <path fill-rule="evenodd" clip-rule="evenodd" d="M0.457764 10C1.73202 5.94291 5.52232 3 9.99997 3C14.4776 3 18.2679 5.94288 19.5422 9.99996C18.2679 14.0571 14.4776 17 9.99995 17C5.52232 17 1.73204 14.0571 0.457764 10ZM14 10C14 12.2091 12.2091 14 10 14C7.79087 14 6.00001 12.2091 6.00001 10C6.00001 7.79086 7.79087 6 10 6C12.2091 6 14 7.79086 14 10Z"/>
        </svg>
        <h5 class="text-sm">This is a preview of your {{ study_type }}. Results will not be saved.</h5>
      </div>
    </div>
  </div>    
</template>

<script>
  export default {
    props: {
      study_type: String
    }
  }
</script>