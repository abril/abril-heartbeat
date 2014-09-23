require "heartbeat_abril/version"
require "heartbeat_abril/heartbeater"
require "json"

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
      Heartbeater.new(@file_path).run!
    end

    def request
      Rack::Request.new @env
    end
  end
end
