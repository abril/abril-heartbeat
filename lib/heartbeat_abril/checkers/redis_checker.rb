module HeartbeatAbril
  class RedisChecker
    def self.is_running?
      RedisWrapper.has_client?
    end

    def self.run!
      status, message = check_redis!
      { "REDIS" => { "status" => status, "status_message" => message }}
    end

    private

    def self.check_redis!
      RedisWrapper.check_status!
      ["OK", "Everything is under control"]
    rescue => exception
      ["FAIL", exception.message]
    end
  end
end
