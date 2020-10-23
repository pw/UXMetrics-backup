class User < ApplicationRecord
  has_secure_password

  has_many :email_verifications, dependent: :destroy
  has_many :password_resets, dependent: :destroy
  has_many :tree_tests, dependent: :destroy
  has_many :card_sorts, dependent: :destroy

  after_create :send_welcome_email

  def send_welcome_email
    PostmarkEmailJob.perform_later(email, 'welcome', {login_url: Rails.application.routes.url_helpers.login_url, username: email, help_url: ''})
  end
end
