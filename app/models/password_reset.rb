class PasswordReset < ApplicationRecord
  belongs_to :user
  has_secure_token
  after_create :send_password_reset_email

  def send_password_reset_email
    PostmarkEmailJob.perform_later(user.email, 'password-reset', {password_reset_url: password_reset_url})    
  end

  def password_reset_url
    Rails.application.routes.url_helpers.set_password_url(token: token)
  end
end
