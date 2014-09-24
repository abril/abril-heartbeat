module HeartbeatAbril
  class RedisWrapper
    def self.check_status!
      Redis.get(:version)
    end

    def self.has_client?
      !!defined?(Redis)
    end
  end
end
