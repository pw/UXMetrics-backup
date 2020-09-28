class ApplicationController < ActionController::Base
  before_action :masquerade_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :redirect_to_new_domain

  def current_payer
    # 'Current' method to refer to for Stripe methods (eg. `.subscription`, etc)
    # Defaults to `current_user`. This is also the class
    # where `include Sjabloon::Stripe` is included (eg. User)
    current_user
  end
  helper_method :current_payer

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :trialend])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


  def default_url_options
    if Rails.env.production?
      Rails.application.routes.default_url_options = { host: ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL'], protocol: 'https' }
    elsif Rails.env.development?
      Rails.application.routes.default_url_options = { host: 'localhost:5000', protocol: 'http' }
    end
  end

  def redirect_to_new_domain
    uri = URI.parse request.url

    if Rails.env.production? && uri.host != ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL']
      uri.host = ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL']
      redirect_to uri.to_s, status: 301
    end

    return true
  end

end
