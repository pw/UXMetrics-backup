class AccountController < ApplicationController
  layout 'dashboard'

  def update_email
    current_user.update(email: params[:email])
    redirect_to account_path, notice: 'Email address updated.'
  rescue ActiveRecord::RecordNotUnique
    redirect_to account_path, notice: 'Unable to update email address.'    
  end

  def change_password
    if current_user.authenticate(params[:current_password])
      current_user.update(password: params[:new_password])
      redirect_to account_path, notice: 'Password updated.'
    else 
      redirect_to account_path, notice: 'Unable to update password.'
    end
  end

  def delete_account
    email = current_user.email
    current_user.destroy
    PostmarkEmailJob.perform_later(email, 'account-closed', {})
    cookies.delete :user_id
    reset_session
    redirect_to root_path, notice: 'Your account has been deleted.'    
  end
end

