class DashboardController < ApplicationController
  skip_before_action :check_verification, only: :verify
  layout 'dashboard'

  def show 
    flash[:notice] = 'Testing...'
    cookies.delete :actioncable_user_id   
  end

  def verify
    if current_user.verified
      redirect_to dashboard_path
    else 
      cookies.encrypted[:actioncable_user_id] = current_user.id
      current_user.email_verifications.create
    end
  end
end

