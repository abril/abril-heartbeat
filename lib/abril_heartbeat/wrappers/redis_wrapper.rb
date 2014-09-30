module AbrilHeartbeat
  class RedisWrapper
    def self.check_status!
      ::REDIS.get(:version)
    end

    def self.client?
      !!defined?(REDIS)
    end
  end
end
