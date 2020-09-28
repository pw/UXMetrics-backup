class AdminController < ApplicationController
  def password_reset
    if Rails.env.development?
      user = User.find_by(email: params[:email])
      raw, hashed = Devise.token_generator.generate(User, :reset_password_token)    
      user.reset_password_token = hashed
      user.reset_password_sent_at = Time.now.utc
      user.save
      puts edit_user_password_path(reset_password_token: raw)
      redirect_to edit_user_password_path(reset_password_token: raw)
    else 
      head :forbidden
    end
  end
end

