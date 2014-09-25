require "json"
require "heartbeat_abril/version"
require "heartbeat_abril/heartbeater"

# Config Loader
require "heartbeat_abril/config_loader"

# Checkers
require "heartbeat_abril/checkers/abstract_checker"
require "heartbeat_abril/checkers/rest_checker"
require "heartbeat_abril/checkers/mongo_checker"
require "heartbeat_abril/checkers/mysql_checker"
require "heartbeat_abril/checkers/redis_checker"

# Wrappers
require "heartbeat_abril/wrappers/mongo_wrapper"
require "heartbeat_abril/wrappers/mysql_wrapper"
require "heartbeat_abril/wrappers/redis_wrapper"

module HeartbeatAbril
  class Middleware
    def initialize(app, options={})
      @app = app
      @file_path = options[:file_path]
    end

    def call(env)
      @env = env
      if request.path == '/heartbeat'
        [200, { 'Content-Type' => 'text/json' }, [response.to_json]]
      else
        @app.call(env)
      end
    end

    private

    def response
      Heartbeater.new({:file_path => @file_path}).run!
    end

    def request
      Rack::Request.new @env
    end
  end
end
