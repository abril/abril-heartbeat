require 'spec_helper'
require 'rack/test'
require 'heartbeat_abril'
require 'json'

describe HeartbeatAbril::Middleware do
  include Rack::Test::Methods

  let(:app)        { ->(env) { [200, env, "app"] } }
  let(:middleware) { described_class.new(app, {file_path: file_path}) }
  let(:file_path)  { "#{File.dirname(__FILE__)}/../support/heartbeat_example.yml" }

  let(:response) { [[api_success_response, api_not_found_response, api_wrong_url_response].to_json] }

  let(:api_success_response) do
    { "api_success" =>
      {
        "url" => "http://www.scudelletti.com",
        "type" => "rest",
        "status_code" => 200,
        "status_message" => "OK"
      }
    }
  end

  let(:api_not_found_response) do
    { "api_not_found" =>
      {
        "url" => "http://www.scudelletti.com/not_found",
        "type" => "rest",
        "status_code" => 404,
        "status_message" => "Page Not Found"
      }
    }
  end

  let(:api_wrong_url_response) do
    { "api_wrong_url" =>
      {
        "url" => "I am a wrong url",
        "type" => "rest",
        "status_code" => nil,
        "status_message" => "bad URI(is not URI?): http://I am a wrong url"
      }
    }
  end

  describe "when middleware handles the request" do
    it "responds success" do
      status, env, body = middleware.call env_for('http://www.example.com/heartbeat')

      expect(status).to eql(200)
      expect(body).to eql(response)
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
