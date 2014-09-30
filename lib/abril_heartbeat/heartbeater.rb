require 'yaml'

module AbrilHeartbeat
  class Heartbeater
    def initialize(options = {})
      ConfigLoader.set_file(options[:file_path]) if options[:file_path]

      @checkers = [MongoChecker, MysqlChecker, RedisChecker]
      @checkers += options[:custom_checkers] if options[:custom_checkers]
    end

    def run!
      response = []
      response << RestChecker.run! if RestChecker.running?

      @checkers.each do |checker|
        response << checker.run! if checker.running?
      end

      response
    end
  end
end
