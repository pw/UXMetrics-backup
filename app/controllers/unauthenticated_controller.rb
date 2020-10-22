class UnauthenticatedController < ApplicationController
  skip_before_action :authenticate, :check_verification
  before_action :check_for_login
  
  protected 

  def check_for_login
    redirect_to dashboard_path if (session[:user_id] || cookies.encrypted[:user_id])
  end
end
