module AbrilHeartbeat
  class MysqlWrapper
    def self.check_status!
      ::ActiveRecord::Base.connection.current_database
    end

    def self.has_client?
      !!defined?(ActiveRecord::Base.connection)
    end
  end
end
