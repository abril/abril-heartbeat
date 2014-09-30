module AbrilHeartbeat
  class AbstractChecker
    def self.running?
      fail NotImplementedError
    end

    def self.module_name
      fail NotImplementedError
    end

    def self.run!
      status, message = check!
      { module_name => { 'status' => status, 'status_message' => message } }
    end

    def self.check!
      fail NotImplementedError
    end
  end
end
