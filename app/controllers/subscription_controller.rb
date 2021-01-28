class SubscriptionController < ApplicationController
  skip_before_action :authenticate, only: :create
  skip_before_action :check_verification, only: :create
  skip_before_action :verify_authenticity_token, only: :create

  require 'json'

  def new
    session = Stripe::Checkout::Session.create(
      success_url: params[:redirect_url],
      cancel_url: params[:redirect_url],
      customer_email: current_user.email,
      client_reference_id: params[:reference_id],
      payment_method_types: ['card'],
      allow_promotion_codes: true,
      mode: 'subscription', 
      line_items: [{
        quantity: 1,
        price: params[:price_id]
      }]
    )
    render json: {session_id: session.id}
  end

  def create
    reference_data = JSON.parse(params[:data][:object][:client_reference_id])
    user = User.find(reference_data['user_id'])
    user.update(stripe_customer_id: params[:data][:object][:customer])
    user.update(subscribed: true)
    head :ok
  end
end
