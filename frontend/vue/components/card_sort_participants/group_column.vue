<template>
  <draggable 
  class="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 xl:w-1/5 h-full"     
  v-model="groups"
  swap-threshold="0.65"
  :group="{ name: 'groups', pull: ['groups'], put: ['cards', 'groups'] }"
  :sort="(sort_type === 'closed') ? false : true"
  ghost-class="container-ghost-class"    
  @updateCards="updateCards"  
  >
    <Group
    v-for="group in groups"
    :key="group.id"
    :id="group.id"
    :can_edit_name="group.can_edit_name"
    :can_delete="group.can_delete"
    v-model="group.name" 
    :initial_cards="group.cards"
    @deleteGroup="deleteGroup"
    @updateCards="updateCards"
    />
  </draggable>

</template>

<script>
  import draggable from 'vuedraggable'
  import Group from './group.vue'

  export default {
    props: {
      value: Array,
      sort_type: String
    },
    data() {
      return {
        groups: this.value
      }
    },
    computed: {
      groups_index: function() {
        if(this.groups.length === 0) {
          return 0
        } else {
          var group_indices = this.groups.map(group => group.id)
          return (Math.max(...group_indices) + 1)
        }
      }
    },
    watch: {
      groups: {
        deep: true, 
        handler() {
          var new_group_index = this.groups.findIndex(group => group.card_sort_id !== undefined)
          if(new_group_index !== -1) {
            var newGroup = this.newGroup()
            newGroup.cards = [this.groups[new_group_index]]
            this.$set(this.groups, new_group_index, newGroup)
          }

          var empty_group_index = this.groups.findIndex(group => group.cards.length === 0)
          if (empty_group_index !== -1) {
            this.groups.splice(empty_group_index, 1)
          }

          this.$emit('input', this.groups)
        }
      }
    },
    methods: {
      addGroup() {
        this.groups = this.groups.concat(this.newGroup())        
      },   
      deleteGroup(id) {
        var index = this.groups.findIndex(i => i.id == id)
        var deleted_cards = this.groups[index].cards
        this.groups.splice(index, 1)
        this.$emit('releaseCards', deleted_cards)
      },         
      newGroup() {
        return {
          id: this.groups_index + 1,
          name: undefined,
          can_delete: true,
          can_edit_name: true,
          cards: []
        }
      },      
      updateCards(group_id, cards) {
        var index = this.groups.findIndex(i => i.id == group_id)
        this.groups[index].cards = cards        
      },
    },
    components: { draggable, Group }
  }
</script>