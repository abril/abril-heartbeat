module HeartbeatAbril
  class MongoChecker
    def self.is_running?
      MongoWrapper.has_client?
    end

    def self.run!
      status, message = check_mongo!
      { "MONGO" => { "status" => status, "status_message" => message }}
    end

    private

    def self.check_mongo!
      MongoWrapper.check_status!
      ["OK", "Everything is under control"]
    rescue => exception
      ["FAIL", exception.message]
    end
  end
end
