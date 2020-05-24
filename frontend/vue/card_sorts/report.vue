<template>
  <div>
    <Nav :name="card_sort.name" :created_at="card_sort.created_at_day" :id="card_sort.id" test_type="card_sorts" />

    <main class="py-6">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="flex flex-wrap items-end mb-16">
          <div class="w-full md:w-1/3 xl:w-2/5 md:pr-16 self-center">
            <Sidebar :test="card_sort" middle_box_description="Unique groups created" :middle_box_value="card_sort.total_groups" />
          </div>
          <div class="w-full md:w-2/3 xl:w-3/5 self-center">
          </div>
        </div>

        <div class="flex flex-wrap">
          <div class="w-full mb-16"> 
            <h2 class="text-2xl mb-4">Detailed Analysis</h2>

            <div class="mb-6">
              <div class="block">
                <div class="border-b border-gray-200 text-gray-500">
                  <nav class="-mb-px flex">
                    <button 
                      @click="tab = 'cards'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab == 'cards' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Cards
                    </button>
                    <button 
                      @click="tab = 'groups'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab === 'groups' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Groups
                    </button>
                    <button 
                      @click="tab = 'individual_results'"
                      :class="{ 'border-purple-500 text-purple-600 focus:outline-none focus:text-purple-800 focus:border-purple-700': tab === 'individual_results' }"
                      class="w-1/2 md:w-1/5 py-4 px-1 text-center border-b-2 border-transparent font-medium text-sm leading-5">
                      Individual Results
                    </button>                    
                  </nav>
                </div>
              </div>
            </div>  

            <div v-show="tab === 'cards'">
              <div class="flex flex-col">
                <div class="-my-2 py-2 overflow-x-auto sm:-mx-6 sm:px-6 lg:-mx-8 lg:px-8">
                  <div class="align-top inline-block min-w-full shadow overflow-hidden sm:rounded-lg border-b border-gray-200">
                    <table class="min-w-full">
                      <thead>
                        <tr>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Card</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Sorted into</th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider"></th>
                          <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs leading-4 font-medium text-gray-500 uppercase tracking-wider">Agreement score</th>
                        </tr>
                      </thead>
                        <tr class="bg-white align-top">
                          <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
                              401(k)
                          </td>
                          <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
                            <ul class="pl-0">
                              <li>
                                  Retirement
                              </li>
                              <li>
                                  Investments
                              </li>
                              <li>
                                  Personal
                              </li>
                            </ul>
                            <a href="#">Show more (2)</a>
                          </td>
                            <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
                              <ul class="pl-0">
                                <li>
                                    5 times
                                </li>
                                <li>
                                    1 time
                                </li>
                                <li>
                                    1 time
                                </li>
                              </ul>
                            </td>
                            <td class="px-6 py-4 whitespace-no-wrap text-sm leading-5 text-gray-900">
                                55.6%
                            </td>
                        </tr>
                    </table>
                  </div>
                </div>
              </div>
            </div>

            <div v-show="tab === 'groups'">     
            </div>

            <div v-show="tab === 'individual_results'">     
            </div>            

          </div>         
        </div>

      </div>
    </main>

  </div>
</template>

<script>
import Rails from '@rails/ujs'
import Nav from '../components/tree_test_report/nav.vue'
import Sidebar from '../components/tree_test_report/sidebar.vue'

export default {
  props: {
    data: {
      type: Array
    }
  },  
  data () {
    return {
      card_sort: this.data[0],
      tab: 'cards'     
    }
  },
  created: function() {
  },
  methods: {
  },
  components: { Nav, Sidebar }
}  
</script>