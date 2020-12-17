<template>
  <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
    <span class="inline-flex rounded-md shadow-sm">
      <button @click="$emit('click')" type="button" class="inline-flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition duration-150 ease-in-out">
        Next
      </button>
    </span>
  </div>   
</template>

<script>
export default {
}
</script>