<template>
  <transition name="flash"> 
    <div v-show="value" class="fixed inset-x-0 bottom-0">
      <div class="relative bg-black opacity-75">
        <div class="max-w-screen-xl mx-auto py-6 px-3 sm:px-6 lg:px-8">
          <div class="pr-16 sm:text-center sm:px-16">
            <p class="font-medium text-white">
              <span class="md:inline">
                {{ notice }}
              </span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>
<script>
  export default {
    props: {
      notice: String, 
      value: Boolean
    },
    watch: {
      value: function(new_value) {
        if(new_value) {
          setTimeout(() => this.$emit('input', false), 5000)
        }
      }
    }
  }
</script>