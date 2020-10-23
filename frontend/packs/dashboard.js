import Rails from "@rails/ujs"
Rails.start()

var Turbolinks = require("turbolinks")
Turbolinks.start()

import { createConsumer } from "@rails/actioncable"
var consumer = createConsumer()
consumer.subscriptions.create('EmailVerificationChannel', {
  received(data) {
    window.location = data['path']
  }
})

import 'alpinejs'

import "../stylesheets/dashboard.css"
require.context('../images', true)

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'

import VueNestable from 'vue-nestable'
import VueClipboard from 'vue-clipboard2'

import NewTreeTest from '../vue/tree_tests/new.vue'
import EditTreeTest from '../vue/tree_tests/edit.vue'
import TreeTestReport from '../vue/tree_tests/report.vue'

import NewCardSort from '../vue/card_sorts/new.vue'
import EditCardSort from '../vue/card_sorts/edit.vue'
import CardSortReport from '../vue/card_sorts/report.vue'

Vue.use(VueNestable)
Vue.use(TurbolinksAdapter)
Vue.use(VueClipboard)

Vue.component('tree-test-new', NewTreeTest)
Vue.component('tree-test-edit', EditTreeTest)
Vue.component('tree-test-report', TreeTestReport)

Vue.component('card-sort-new', NewCardSort)
Vue.component('card-sort-edit', EditCardSort)
Vue.component('card-sort-report', CardSortReport)

document.addEventListener('turbolinks:load', function() { 
  const app = new Vue({
    el: '[data-behavior="vue"]',
  })
})
