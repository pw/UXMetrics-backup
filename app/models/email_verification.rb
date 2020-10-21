class EmailVerification < ApplicationRecord
  belongs_to :user
  has_secure_token
  after_create :send_verification_email

  def send_verification_email
    client = client = Postmark::ApiClient.new(ENV['POSTMARK_SERVER_TOKEN'], http_open_timeout: 15)
    client.deliver_with_template(from: 'UX Metrics <support@uxmetrics.com>', to: user.email, template_alias: 'email-verification', template_model: {email_verification_url: verification_url})
  end 

  def verification_url
    Rails.application.routes.url_helpers.email_verification_url(token: token)
  end
end
