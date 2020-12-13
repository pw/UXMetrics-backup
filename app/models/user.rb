class User < ApplicationRecord
  has_secure_password

  has_many :email_verifications, dependent: :destroy
  has_many :password_resets, dependent: :destroy
  has_many :tree_tests, dependent: :destroy
  has_many :card_sorts, dependent: :destroy

  after_update :send_welcome_email

  def send_welcome_email
    if verified && !welcome_email_sent
      PostmarkEmailJob.perform_later(email, 'welcome', {login_url: Rails.application.routes.url_helpers.login_url, username: email, help_url: ''}) 
      self.update(welcome_email_sent: true)
    end
  end
end
