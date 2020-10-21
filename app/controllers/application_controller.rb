class ApplicationController < ActionController::Base
  before_action :redirect_to_new_domain
  before_action :authenticate
  before_action :check_verification

  helper_method :current_user

  protected

  def redirect_to_new_domain
    uri = URI.parse request.url

    if Rails.env.production? && uri.host != ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL']
      uri.host = ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL']
      redirect_to uri.to_s, status: 301
    end

    return true
  end

  def authenticate
    if session[:user_id]
      @current_user = User.find(session[:user_id]) 
    elsif cookies.encrypted[:user_id]
      @current_user = User.find(cookies.encrypted[:user_id])
      session[:user_id] = @current_user.id
      flash.now[:notice] = 'Welcome back.'
    else 
      redirect_to login_path, notice: 'Please log in.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to login_path, notice: 'Please log in.'
  end

  def authenticate_admin
    redirect_to root_path unless current_user.admin
  end

  def current_user
    @current_user
  end

  def admin?
    current_user.admin
  end

  def check_verification
    redirect_to verify_path unless current_user.verified
  end
end
