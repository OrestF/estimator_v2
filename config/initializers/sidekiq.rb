require 'sidekiq'

url = Redis.current.connection[:id]
redis_params = { url: url, size: 12,  network_timeout: 5 }

Sidekiq.configure_server do |config|
  config.redis = redis_params
end

Sidekiq.configure_client do |config|
  config.redis = redis_params
end