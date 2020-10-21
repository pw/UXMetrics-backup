class PasswordReset < ApplicationRecord
  belongs_to :user
  has_secure_token
  after_create :send_password_reset_email

  def send_password_reset_email
    puts 'start'
    client = client = Postmark::ApiClient.new(ENV['POSTMARK_SERVER_TOKEN'], http_open_timeout: 15)
    puts 'middle'
    client.deliver_with_template(from: 'UX Metrics <support@uxmetrics.com>', to: user.email, template_alias: 'password-reset', template_model: {password_reset_url: password_reset_url})
    puts 'end'
  end

  def password_reset_url
    Rails.application.routes.url_helpers.set_password_url(token: token)
  end
end
