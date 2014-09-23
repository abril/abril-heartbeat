require "heartbeat_abril/version"

module HeartbeatAbril
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env

      if request.path == '/heartbeat'
        [200, { 'application/json' => 'text/html' }, "Tun-Tun!"]
      else
        @app.call(env)
      end
    end

    private

    def request
      Rack::Request.new @env
    end
  end
end