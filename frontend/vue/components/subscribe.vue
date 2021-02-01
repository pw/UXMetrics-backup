<template>
  <div class="fixed z-10 inset-0 overflow-y-auto">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <transition name="overlay">
        <div v-show="show" class="fixed inset-0 transition-opacity">
          <div class="absolute inset-0 bg-gray-500 opacity-75"></div>
        </div>
      </transition>

      <span class="hidden sm:inline-block sm:align-middle sm:h-screen"></span>&#8203;

      <transition name="modal">
        <div v-show="show" class="inline-block align-bottom bg-gray-100 rounded-lg border-purple-600 border-4 px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle w-full lg:max-w-7xl sm:p-6" role="dialog" aria-modal="true" aria-labelledby="modal-headline">
          <div class="hidden sm:block absolute top-0 right-0 pt-4 pr-4">
            <button @click="$emit('close')" type="button" class="text-gray-400 hover:text-gray-500 focus:outline-none focus:text-gray-500 transition ease-in-out duration-150" aria-label="Close">
              <!-- Heroicon name: x -->
              <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>
          <div>
            <div class="my-3 text-center sm:my-6">
              <h3 class="text-3xl leading-9 font-extrabold text-gray-900">
                Ready to go pro?
              </h3>
              <div class="mt-2">
                <p class="text-xl text-gray-500 sm:text-center">
                  Unlock unlimited access to all pro features for an entire year.
                </p>
              </div>
            </div>
            <div class="space-y-4 sm:space-y-0 sm:grid sm:grid-cols-2 sm:gap-6 lg:max-w-4xl lg:mx-auto xl:max-w-none xl:mx-0">
              <div class="border border-gray-200 rounded-lg shadow-sm divide-y divide-gray-200">
                <div class="p-6">
                  <h2 class="text-lg leading-6 font-medium text-gray-900">Basic</h2>
                  <p class="mt-4 text-sm text-gray-500">Do professional user research without limits.</p>
                  <p class="mt-8">
                    <span class="text-4xl font-extrabold text-gray-900">Free</span>
                  </p>
                </div>
                <div class="pt-6 pb-8 px-6">
                  <h3 class="text-xs font-medium text-gray-900 tracking-wide uppercase">What's included</h3>
                  <ul class="mt-6 space-y-4">
                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500"><strong>Unlimited</strong> studies</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500"><strong>Unlimited</strong> participant results per study</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Great participant experience on any device (desktop or mobile)</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Customizable greetings and thank you messages</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Remote or lab, moderated or unmoderated</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Detailed analysis tools to make sense of your results</span>
                    </li>
                  </ul>
                </div>
              </div>

              <div class="border border-gray-200 rounded-lg shadow-sm divide-y divide-gray-200">
                <div class="p-6">
                  <h2 class="text-lg leading-6 font-medium text-gray-900">Pro</h2>
                  <p class="mt-4 text-sm text-gray-500">Premium features to enhance your studies.</p>
                  <p class="mt-8">
                    <span class="text-4xl font-extrabold text-gray-900">$99</span>
                    <span class="text-base font-medium text-gray-500">/year</span>
                  </p>
                </div>
                <div class="pt-6 pb-8 px-6">
                  <h3 class="text-xs font-medium text-gray-900 tracking-wide uppercase">Everything in Basic, plus...</h3>
                  <ul class="mt-6 space-y-4">
                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Custom branding on your studies and reports</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Card and task randomization</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Advanced report sharing and password protection</span>
                    </li>

                    <li class="flex space-x-3">
                      <!-- Heroicon name: check -->
                      <svg class="flex-shrink-0 h-5 w-5 text-teal-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                        <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                      </svg>
                      <span class="text-sm text-gray-500">Priority email support</span>
                    </li>

                  </ul>
                  <a @click="subscribe" class="mt-8 block w-full bg-teal-500 border border-transparent rounded-md py-2 text-sm font-semibold text-white text-center hover:bg-teal-400 focus:outline-none focus:shadow-outline transition duration-150 ease-in-out cursor-pointer">Upgrade to Pro</a>
                </div>
              </div>
            </div>

          </div>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
import Rails from '@rails/ujs'

export default {
  props: {
    show: Boolean,
    redirect_url: String,
    user_id: Number
  },
  data () {
    return {
    }
  },
  methods: {
    subscribe() {
      var reference_id = {
        user_id: this.user_id,
      }
      var data = new FormData
      data.append('redirect_url', this.redirect_url)
      data.append('price_1IFtBkBkaUHJfABOCIgf5MTW')
      data.append('reference_id', JSON.stringify(reference_id))
      Rails.ajax({
        url: '/subscription/new',
        type: 'POST',
        data: data,
        success: (response) => {
          var stripe = Stripe('pk_test_51HTwIfBkaUHJfABO5bK5uD4GUK8PKMCAMm3yChrwAOjd8fuqj8MbcMBcJlULuHIaqW9QFg6e8DBk3ttrOXRJKjv400VXIlFfWs')
          stripe.redirectToCheckout({
            sessionId: response.session_id
          })
        }
      })
    }    
  }
}
</script>