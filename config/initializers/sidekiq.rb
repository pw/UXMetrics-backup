Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOSTPORT']}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOSTPORT']}" }
end