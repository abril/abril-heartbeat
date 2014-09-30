module AbrilHeartbeat
  class MongoWrapper
    def self.check_status!
      ::Mongoid.default_session.command(ping: 1)
    end

    def self.client?
      !!defined?(Mongoid)
    end
  end
end
