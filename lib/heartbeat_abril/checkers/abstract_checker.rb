module HeartbeatAbril
  class AbstractChecker
    def self.is_running?
      raise NotImplementedError
    end

    def self.module_name
      raise NotImplementedError
    end

    def self.run!
      status, message = check!
      { module_name => { "status" => status, "status_message" => message }}
    end

    private

    def self.check!
      raise NotImplementedError
    end
  end
end
