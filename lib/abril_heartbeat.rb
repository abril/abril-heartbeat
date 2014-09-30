require 'json'
require 'abril_heartbeat/version'
require 'abril_heartbeat/heartbeater'

# Config Loader
require 'abril_heartbeat/config_loader'

# Checkers
require 'abril_heartbeat/checkers/abstract_checker'
require 'abril_heartbeat/checkers/rest_checker'
require 'abril_heartbeat/checkers/mongo_checker'
require 'abril_heartbeat/checkers/mysql_checker'
require 'abril_heartbeat/checkers/redis_checker'

# Wrappers
require 'abril_heartbeat/wrappers/mongo_wrapper'
require 'abril_heartbeat/wrappers/mysql_wrapper'
require 'abril_heartbeat/wrappers/redis_wrapper'

module AbrilHeartbeat
  class Middleware
    def initialize(app, options = {})
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
      Heartbeater.new(file_path: @file_path).run!
    end

    def request
      Rack::Request.new @env
    end
  end
end
