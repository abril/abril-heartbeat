module HeartbeatAbril
  class MysqlChecker
    def self.is_running?
      MysqlWrapper.has_client?
    end

    def self.run!
      status, message = check_mysql!
      { "MYSQL" => { "status" => status, "status_message" => message }}
    end

    private

    def self.check_mysql!
      MysqlWrapper.check_status!
      ["OK", "Everything is under control"]
    rescue => exception
      ["FAIL", exception.message]
    end
  end
end
