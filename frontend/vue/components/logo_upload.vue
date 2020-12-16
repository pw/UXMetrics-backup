<template>
  <div class="sm:col-span-4" :class="{'opacity-50': !enabled}">
    <label for="logo" class="block text-sm leading-5 font-medium text-gray-700">
        Logo
    </label>
    <p class="mb-2 text-sm text-gray-500">{{ instructions }}</p>
    <img v-show="value !== ''" :src="logo_base_url + '/' + value" class="mb-6 w-40">
    <div class="mt-2 flex items-center">
      <span class="rounded-md shadow-sm">
        <button @click="openUpload" type="button" :class="{'cursor-default': !enabled, 'hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:bg-gray-50 active:text-gray-800': enabled}"" class="py-2 px-3 border border-gray-300 rounded-md text-sm leading-4 font-medium text-gray-700 transition duration-150 ease-in-out">
            Choose File
        </button>
      </span>
    </div>
  </div>  
</template>

<script>
import * as filestack from 'filestack-js'
const filestack_client = filestack.init('AuALnf2VzTPqJAkEOLar1z');

export default {
  props: {
    value: String,
    instructions: String,
    logo_base_url: String,
    enabled: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {

    }
  },
  methods: {
    openUpload() {
      if(!this.enabled) {
        return
      }
      const options = {
        fromSources: ['local_file_system', 'url'],
        transformations: {
          crop: true, 
          rotate: true
        },
        accept: ['image/*'],
        onUploadDone: (arg) => {
          this.$emit('input', arg.filesUploaded[0].key)
        }
      }
      filestack_client.picker(options).open()
    }   
  }
}
</script>