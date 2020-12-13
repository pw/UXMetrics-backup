class DashboardController < ApplicationController
  skip_before_action :check_verification, only: [:verify, :reverify]
  layout 'dashboard'

  def show 
    cookies.delete :actioncable_user_id   
    @card_sorts = current_user.card_sorts.group(:status).count
    @tree_tests = current_user.tree_tests.group(:status).count
  end

  def verify
    if current_user.verified
      redirect_to dashboard_path
    else 
      cookies.encrypted[:actioncable_user_id] = current_user.id
    end
  end

  def reverify
    current_user.email_verifications.create unless current_user.verified
    redirect_to dashboard_path
  end
end

