class EmailVerification < ApplicationRecord
  belongs_to :user
  has_secure_token
  after_create :send_verification_email

  def send_verification_email
    PostmarkEmailJob.perform_later(user.email, 'email-verification', {email_verification_url: verification_url})
  end 

  def verification_url
    Rails.application.routes.url_helpers.email_verification_url(token: token)
  end
end
