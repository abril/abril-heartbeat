module HeartbeatAbril
  class MysqlChecker < AbstractChecker
    def self.is_running?
      MysqlWrapper.has_client?
    end

    def self.module_name
      "MYSQL"
    end

    private

    def self.check!
      MysqlWrapper.check_status!
      ["OK", "Everything is under control"]
    rescue => exception
      ["FAIL", exception.message]
    end
  end
end
