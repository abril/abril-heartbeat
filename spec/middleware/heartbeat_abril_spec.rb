require 'spec_helper'
require 'rack/test'
require 'heartbeat_abril'
require 'json'

describe HeartbeatAbril::Middleware do
  include Rack::Test::Methods

  let(:app)        { ->(env) { [200, env, "app"] } }
  let(:middleware) { described_class.new(app, {file_path: file_path}) }
  let(:file_path)  { "#{File.dirname(__FILE__)}/../support/heartbeat_example.yml" }
  let(:response)   { [[api_success_response, api_not_found_response, api_wrong_url_response].to_json] }
  let(:api_success_response)   { build(:api_success) }
  let(:api_not_found_response) { build(:api_not_found) }
  let(:api_wrong_url_response) { build(:api_wrong_url) }

  describe "when middleware handles the request" do
    it "responds success" do
      status, env, body = middleware.call env_for('http://www.example.com/heartbeat')

      expect(status).to eql(200)
      expect(body).to eql(response)
    end
  end

  describe "when middleware does not handle the request" do
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
