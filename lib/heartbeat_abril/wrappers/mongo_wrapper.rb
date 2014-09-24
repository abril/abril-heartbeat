module HeartbeatAbril
  class MongoWrapper
    def self.check_status!
      ::Mongoid.default_session.command(ping: 1)
    end

    def self.has_client?
      !!defined?(Mongoid)
    end
  end
end
