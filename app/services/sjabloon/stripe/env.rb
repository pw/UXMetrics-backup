module Sjabloon
  module Stripe
    module Env
      ::Stripe.api_key             = ENV['STRIPE_SECRET_KEY']
      ::StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']
    end
  end
end

