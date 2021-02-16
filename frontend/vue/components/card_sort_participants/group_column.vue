<template>
  <draggable 
  class="w-1/5 h-full"     
  v-model="groups"
  swap-threshold="0.65"
  :group="{ name: 'groups', pull: ['groups'], put: draggablePut() }"
  :sort="(sort_type === 'closed') ? false : true"
  ghost-class="container-ghost-class"    
  @updateCards="updateCards"  
  @add="cardMove"
  >
    <Group
    v-for="(group, index) in groups"
    :key="group.id"
    :id="group.id"
    :index="index"
    ref="group"    
    :group_column_index="column_index" 
    :draggable="sort_type !== 'closed'"
    :can_edit_name="group.can_edit_name"
    :can_delete="group.can_delete"
    v-model="group.name" 
    :initial_cards="group.cards"
    @deleteGroup="deleteGroup"
    @updateCards="updateCards"
    @cardMove="cardMove"
    @saveGroupName="saveGroupName"
    />
  </draggable>

</template>

<script>
  import draggable from 'vuedraggable'
  import Group from './group.vue'

  export default {
    props: {
      value: Array,
      sort_type: String,
      column_index: Number
    },
    data() {
      return {
        groups: this.value
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
          if (empty_group_index !== -1 && this.groups[empty_group_index].can_delete) {
            this.groups.splice(empty_group_index, 1)
          }

          this.$emit('input', this.groups)
        }
      }
    },
    methods: { 
      cardMove(event) {
        this.$emit('cardMove', event)
      },
      saveGroupName(event) {
        this.$emit('saveGroupName', event)
      },
      deleteGroup(id) {
        var index = this.groups.findIndex(i => i.id == id)
        var deleted_cards = this.groups[index].cards
        this.groups.splice(index, 1)
        this.$emit('releaseCards', deleted_cards)
      },    
      draggablePut(){
        if(this.sort_type === 'closed') {
          return false
        } else {
          return ['groups', 'cards']
        }
      },           
      newGroup() {
        return {
          id: (Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15)),
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