<template>
  <div class="flex-1 flex">
    <div class="flex-1 min-w-0">
      <div class="rounded-md shadow-sm" :class="{'shadow-none': disabled}">
        <input class="form-input px-2 py-1 block w-full transition duration-150 ease-in-out text-sm font-medium leading-5 text-gray-700" :class="{'border-none': disabled}" :disabled="disabled" :placeholder="placeholder_text"  @dragstart="$emit('ac')" :value="value" @input="$emit('input', $event.target.value)" @blur="$emit('blur')" />
      </div>
    </div>
    <div class="ml-1">
      <span v-if="!(item.id == tree[0].id && tree.length == 1)  && !disabled" @click="$emit('remove', item.id)" class="inline-flex rounded-md shadow-sm">
        <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-red-700 bg-red-100 hover:bg-red-50 focus:outline-none focus:border-red-300 focus:shadow-outline-red active:bg-red-200 transition ease-in-out duration-150">
          -
        </button>
      </span>      
      <span @click="$emit('add', item.id)" v-if="!disabled" class="inline-flex rounded-md shadow-sm">
        <button type="button" class="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs leading-4 font-medium rounded text-white bg-purple-600 hover:bg-purple-500 focus:outline-none focus:border-purple-700 focus:shadow-outline-purple active:bg-purple-700 transition ease-in-out duration-150">
          +
        </button>
      </span>
    </div>
  </div>  
</template>

<script>
export default {
  props: {
    placeholder_text: String, 
    item: Object,
    tree: Array, 
    value: String, 
    disabled: {
      type: Boolean,
      default: false
    }
  }
}
</script>