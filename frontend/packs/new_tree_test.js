import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../vue/new_tree_test.vue'
import VueNestable from 'vue-nestable'

Vue.use(VueNestable)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', function() { 
  const app = new Vue({
    el: '#vue',
    template: '<App/>',
    components: { App }
  })
})