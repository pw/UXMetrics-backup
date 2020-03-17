<template>
  <vue-nestable v-model="tree">
    <vue-nestable-handle
      slot-scope="{ item }"
      :item="item">
      <Node @remove="remove" @add="add" :item="item" :tree="tree" :placeholder_text="item.placeholder_text"/>
    </vue-nestable-handle>
  </vue-nestable>	
</template>

<script>
import Node from './editable_tree_node.vue'
var _ = require('lodash');
export default {
  data () {
    return {
    	node_index: 2,
      tree: [
      	{
      		id: 0,
      		placeholder_text: 'Home',
      		children: [{
      			id: 1,
      			placeholder_text: 'Child',
      			children: [{
      				id: 2,
      				placeholder_text: 'Child of Child',
      				children: []
      			}]
      		}]
      	}
      ]
    }
  },
  methods: {
  	add: function(id) {
  		this.node_index += 1
  		this.addToArray(this.tree, id)
  	},
  	remove: function(id) {
			this.removeFromArray(this.tree, id)
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
  	addChild(node) {
  		node.children.push({id: this.node_index, children: []})
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
  	}
  },
  components: { Node }
}
</script>