class PostmarkEmailJob < ApplicationJob
  queue_as :default

  def perform(to_email, template_alias, template_model)
    client = client = Postmark::ApiClient.new(ENV['POSTMARK_SERVER_TOKEN'], http_open_timeout: 15)
    client.deliver_with_template(
      from: 'UX Metrics <support@uxmetrics.com>', 
      to: to_email, 
      template_alias: template_alias,
      template_model: template_model
    )    
  end
end
