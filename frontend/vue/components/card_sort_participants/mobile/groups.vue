<template>
  <draggable 
  class="pb-12 flex overflow-x-auto"     
  v-model="groups"
  swap-threshold="0.65"
  :group="{ name: 'groups', pull: false, put: draggablePut() }"
  :sort="sort_type === 'closed' ? false : true"
  ghost-class="container-ghost-class-mobile" 
  filter=".undraggable" 
  handle=".handle"  
  @updateCards="updateCards"  
  @add="cardMove"
  >
    <Group
    class="w-64 flex-shrink-0"
    v-for="(group, index) in groups"
    :key="group.id"
    :id="group.id"
    :index="index"
    ref="group"    
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
      sort_type: String
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
          var index = this.groups.findIndex(group => group.cards.length === 0 && group.name === undefined) 
          if (index !== -1 && this.groups[index].can_delete && index !== this.groups.length - 1) {
            this.groups.splice(index, 1)
          }
       
          if(this.sort_type !== 'closed' && this.groups[this.groups.length - 1].cards.length != 0) {
            this.groups.push(this.newGroup())
          }

          this.$emit('input', this.groups)
        }
      }
    },
    created(){
      if(this.sort_type !== 'closed') {
        this.groups.push(this.newGroup())
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
        return false
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