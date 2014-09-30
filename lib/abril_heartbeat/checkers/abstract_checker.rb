module AbrilHeartbeat
  class AbstractChecker
    def self.running?
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
