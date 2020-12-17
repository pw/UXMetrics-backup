<template>
  <div>
    <div class="sm:col-span-4">
      <label class="mb-2 block text-sm leading-5 font-medium text-gray-700">
        Cards
      </label>
      <Draggable
        v-if="enabled"
        v-model="cards"
        @change="saveCards"
        ghost-class="group-list-ghost-class"
      >
        <Card 
          v-for="(card, index) in cards"
          ref="card_refs" 
          :value="card"
          @input="$set(cards, index, $event)"
          @removeCard="removeCard" 
          @nextCard="nextCard"
          @saveCard="saveCard" 
        />           
      </Draggable> 
      <Card
        v-else
        v-for="card in cards"
        :value="card"
        :disabled="true"
      />                
      <span class="shadow-sm rounded-md">
        <button @click="addCard" class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm leading-5 font-medium rounded-md text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
          <svg class="-ml-1 mr-2 h-5 w-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M10 18C14.4183 18 18 14.4183 18 10C18 5.58172 14.4183 2 10 2C5.58172 2 2 5.58172 2 10C2 14.4183 5.58172 18 10 18ZM11 7C11 6.44772 10.5523 6 10 6C9.44772 6 9 6.44772 9 7V9H7C6.44772 9 6 9.44771 6 10C6 10.5523 6.44772 11 7 11H9V13C9 13.5523 9.44772 14 10 14C10.5523 14 11 13.5523 11 13V11H13C13.5523 11 14 10.5523 14 10C14 9.44772 13.5523 9 13 9H11V7Z" />
          </svg>
          New Card
        </button>
      </span>
    </div>                    
  </div>
</template>

<script>
import Rails from '@rails/ujs' 
import Draggable from 'vuedraggable' 
import Card from './card.vue'

export default {
  components: { Draggable, Card },
  props: {
    value: Array,
    card_sort_id: Number,
    enabled: {
      type: Boolean,
      default: true
    }
  },
  data() {
    return {
      cards: this.value
    }
  },
  methods: {
    saveCards() {
      if(!this.enabled) { return }

      var data = new FormData
      this.cards.forEach((card, index) => {
        data.append(`card_sort[card_sort_cards_attributes][${index}][id]`, card.id)
        data.append(`card_sort[card_sort_cards_attributes][${index}][title]`, card.title)
        data.append(`card_sort[card_sort_cards_attributes][${index}][description]`, card.description)        
        data.append(`card_sort[card_sort_cards_attributes][${index}][has_description]`, card.has_description)
        data.append(`card_sort[card_sort_cards_attributes][${index}][order]`, index)        
      })
      Rails.ajax({
        url: '/card_sorts/' + this.card_sort_id,
        type: 'PATCH',
        data: data
      })
    },    
    removeCard(id) {
      if(!this.enabled) { return }      
      var index = this.cards.findIndex(i => i.id == id)
      var data = new FormData
      Rails.ajax({
        url: '/card_sort_cards/' + id,
        type: 'DELETE',
        success: (arg) => {
          this.cards.splice(index, 1)
        }
      })
    },  
    nextCard: function(card_id) {
      var index = this.cards.findIndex(i => i.id == card_id)
      if(index === this.cards.length - 1) {
        this.addCard()       
      } else {
        this.$nextTick(function() {
          this.$refs.card_refs[index + 1].$refs.title.focus()        
        })
      }      
    },     
    addCard() {
      if(!this.enabled) { return }

      var index = this.cards.length
      var data = new FormData
      data.append('card_sort_card[order]', index)
      data.append('card_sort_card[card_sort_id]', this.card_sort_id)
      Rails.ajax({
        url: '/card_sort_cards',
        type: 'POST',
        data: data,
        success: (arg) => {
          this.cards.push(arg)
          this.$nextTick(function() {
            this.$refs.card_refs[this.cards.length - 1].$refs.title.focus()
          })          
        }
      })
    }, 
    saveCard: function(card_id) {
      if(!this.enabled) { return }
            
      var card = this.cards.find(i => i.id == card_id)
      var data = new FormData
      data.append('card_sort_card[id]', card.id)
      data.append('card_sort_card[title]', card.title)
      data.append('card_sort_card[description]', card.description)
      data.append('card_sort_card[has_description]', card.has_description)
      Rails.ajax({
        url: '/card_sort_cards/' + card_id,
        type: 'PATCH',
        data: data
      })
    },           
  }
}
</script>