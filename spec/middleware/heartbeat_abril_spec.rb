require 'spec_helper'
require 'rack/test'
require 'heartbeat_abril'

describe HeartbeatAbril::Middleware do
  include Rack::Test::Methods

  let(:app)        { ->(env) { [200, env, "app"] } }
  let(:middleware) { described_class.new(app) }

  describe "when middleware handles the request" do
    it "responds success" do
      status, env, body = middleware.call env_for('http://www.example.com/heartbeat')

      expect(status).to eql(200)
      expect(body).to eql("Tun-Tun!")
    end
  end

  describe "when middleware does not handles the request" do
    it "responds success" do
      status, env, body = middleware.call env_for('http://www.example.com/')

      expect(status).to eql(200)
      expect(body).to eql("app")
    end
  end

  def env_for(url, opts={})
    Rack::MockRequest.env_for(url, opts)
  end
end
