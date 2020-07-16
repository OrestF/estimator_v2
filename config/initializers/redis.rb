Redis.current = Redis.new(url: RCreds.fetch(:redis, :url, default: 'redis://localhost:6379/0'))
