/* eslint no-console:0 */
require("turbolinks").start()

import "../stylesheets/participants.css"

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import NewTreeTestParticipant from '../vue/tree_test_participants/new.vue'
import NewCardSortParticipant from '../vue/card_sort_participants/new.vue'

Vue.use(TurbolinksAdapter)

Vue.component('tree-test-participant-new', NewTreeTestParticipant)
Vue.component('card-sort-participant-new', NewCardSortParticipant)

document.addEventListener('turbolinks:load', function() { 
  const app = new Vue({
    el: '[data-behavior="vue"]',
  })
})
