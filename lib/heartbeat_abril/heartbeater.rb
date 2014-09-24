require "yaml"

module HeartbeatAbril
  class Heartbeater
    def initialize(file_path, options={})
      ConfigLoader.set_file(file_path)

      @checkers = [MongoChecker, MysqlChecker]
      @checkers += options[:custom_checkers] if options[:custom_checkers]
    end

    def run!
      response = []
      response << RestChecker.run! if RestChecker.is_running?

      @checkers.each do |checker|
        response << checker.run! if checker.is_running?
      end

      response
    end
  end
end
