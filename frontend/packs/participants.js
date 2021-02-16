/* eslint no-console:0 */
import Rails from "@rails/ujs"
Rails.start()

var Turbolinks = require("turbolinks")
Turbolinks.start()

import "../stylesheets/participants.css"

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import VueWindowSize from 'vue-window-size'
import NewTreeTestParticipant from '../vue/tree_test_participants/new.vue'
import NewCardSortParticipant from '../vue/card_sort_participants/new.vue'
import NewCardSortParticipantMobile from '../vue/card_sort_participants/new_mobile.vue'

import HoneybadgerVue from '@honeybadger-io/vue'
const config = {
  apiKey: '853438db',
  environment: 'production'
}
Vue.use(HoneybadgerVue, config)

Vue.use(TurbolinksAdapter)
Vue.use(VueWindowSize)

Vue.component('tree-test-participant-new', NewTreeTestParticipant)
Vue.component('new-card-sort-participant', NewCardSortParticipant)
Vue.component('new-card-sort-participant-mobile', NewCardSortParticipantMobile)

document.addEventListener('turbolinks:load', function() { 
  const app = new Vue({
    el: '[data-behavior="vue"]',
  })
})
