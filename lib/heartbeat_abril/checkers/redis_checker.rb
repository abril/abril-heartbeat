module HeartbeatAbril
  class RedisChecker < AbstractChecker
    def self.is_running?
      RedisWrapper.has_client?
    end

    def self.module_name
      "REDIS"
    end

    private

    def self.check!
      RedisWrapper.check_status!
      ["OK", "Everything is under control"]
    rescue => exception
      ["FAIL", exception.message]
    end
  end
end
