require "yaml"

module HeartbeatAbril
  class Heartbeater
    def initialize(file_path)
      @rest_hash = ::YAML.load_file(file_path)
    end

    def run!
      response = []
      response << RestChecker.run!(@rest_hash) if RestChecker.app_has_rest_calls?(@rest_hash)
      response << MongoChecker.run! if MongoChecker.app_has_mongo?
      response << MysqlChecker.run! if MysqlChecker.app_has_mysql?

      response
    end
  end
end
