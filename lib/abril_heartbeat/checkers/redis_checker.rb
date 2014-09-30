module AbrilHeartbeat
  class RedisChecker < AbstractChecker
    def self.running?
      RedisWrapper.client?
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
