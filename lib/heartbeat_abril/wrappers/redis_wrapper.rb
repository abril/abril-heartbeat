module HeartbeatAbril
  class RedisWrapper
    def self.check_status!
      REDIS.get(:version)
    end

    def self.has_client?
      !!defined?(REDIS)
    end
  end
end
