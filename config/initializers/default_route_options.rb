if Rails.env.production?
  Rails.application.routes.default_url_options = { host: ENV['FULL_APP_DOMAIN_WITHOUT_PROTOCOL'], protocol: 'https' }
elsif Rails.env.development?
  Rails.application.routes.default_url_options = { host: 'localhost:5000', protocol: 'http' }
end