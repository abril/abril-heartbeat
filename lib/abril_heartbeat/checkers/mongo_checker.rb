module AbrilHeartbeat
  class MongoChecker < AbstractChecker
    def self.running?
      MongoWrapper.client?
    end

    def self.module_name
      'MONGO'
    end

    def self.check!
      MongoWrapper.check_status!
      ['OK', 'Everything is under control']
    rescue => exception
      ['FAIL', exception.message]
    end
  end
end
