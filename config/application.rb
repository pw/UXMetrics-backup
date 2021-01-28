require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_job/railtie'
require 'action_cable/engine'

Bundler.require(*Rails.groups)

module UXMetrics
  class Application < Rails::Application
    config.application_naked_domain = ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL']
    config.application_domain = ENV['FULL_APP_DOMAIN']
    config.application_name = ENV['APP_NAME']
    config.load_defaults 5.2
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq
  end
end
