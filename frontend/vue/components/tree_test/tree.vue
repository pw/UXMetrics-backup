<template>
  <VueNestable 
  :hooks="{'beforeMove': beforeMove }" 
  v-model="tree"
  @change="saveTree"
  >
    <div class="flex" slot-scope="{ item }">
      <VueNestableHandle 
      v-if="!(item.id == tree[0].id && tree.length == 1)" 
      :item="item">   
        <div class="py-1">
          <svg class="h-6 w-6 text-gray-700" fill="currentColor" viewBox="0 0 24 24" stroke="none">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M10 3C10.2652 3 10.5196 3.10536 10.7071 3.29289L13.7071 6.29289C14.0976 6.68342 14.0976 7.31658 13.7071 7.70711C13.3166 8.09763 12.6834 8.09763 12.2929 7.70711L10 5.41421L7.70711 7.70711C7.31658 8.09763 6.68342 8.09763 6.29289 7.70711C5.90237 7.31658 5.90237 6.68342 6.29289 6.29289L9.29289 3.29289C9.48043 3.10536 9.73478 3 10 3ZM6.29289 12.2929C6.68342 11.9024 7.31658 11.9024 7.70711 12.2929L10 14.5858L12.2929 12.2929C12.6834 11.9024 13.3166 11.9024 13.7071 12.2929C14.0976 12.6834 14.0976 13.3166 13.7071 13.7071L10.7071 16.7071C10.3166 17.0976 9.68342 17.0976 9.29289 16.7071L6.29289 13.7071C5.90237 13.3166 5.90237 12.6834 6.29289 12.2929Z"/>
          </svg> 
        </div>            
      </VueNestableHandle>
      <TreeNode 
      @add="add"
      @remove="remove"
      @blur="saveTree"
      :item="item" 
      v-model="item.text" 
      :tree="tree" 
      :placeholder_text="item.placeholder_text"/>
    </div>
  </VueNestable>
</template>

<script>
import TreeNode from './tree_node.vue'  
import Rails from '@rails/ujs'
export default {
  props: {
    value: String,
    tree_test_id: Number
  },
  data() {
    return {
      tree: JSON.parse(this.value)
    }
  },
  methods: {
    saveTree() {
      var data = new FormData 
      data.append('tree_test[tree]', JSON.stringify(this.tree))     
      Rails.ajax({
        url: '/tree_tests/' + this.tree_test_id,
        type: 'PATCH', 
        data: data,
        success: (response) => {
          this.$emit('input', JSON.stringify(this.tree))
        }
      }) 
    }, 
    add: function(id) {
      this.addToArray(this.tree, id)
      this.saveTree()
    },
    remove: function(id) {
      this.removeFromArray(this.tree, id)
      this.saveTree()
    },    
    beforeMove({dragItem, pathFrom, pathTo}) {
      if(pathTo.length === 1) {
        return false
      } else {
        return true
      }
    },
    addToArray(array, id) {
      var index = array.findIndex(i => i.id == id)
      if(index != -1)
        this.addChild(array[index])
      else 
        array.forEach((element) => {
          if(element.children !== undefined)
            this.addToArray(element.children, id)
        })
    },  
    removeFromArray(array, id) {
      var index = array.findIndex(i => i.id == id)
      if(index != -1)
        array.splice(index, 1)
      else 
        array.forEach((element) => {
          if(element.children !== undefined)
            this.removeFromArray(element.children, id)
        })
    },      
    addChild(node) {
      node.children.push({id: this.current_tree_index + 1, children: []})
    },    
    highestId(node){ 
      var highest = node.id
      node.children.forEach((child) => {
        var child_highest = this.highestId(child)
        if(child_highest > highest) {
          highest = child_highest
        }
      })
      return highest
    }      
  },
  computed: {
    current_tree_index() {
      return this.highestId(this.tree[0])
    }
  },
  components: { TreeNode }
}
</script>