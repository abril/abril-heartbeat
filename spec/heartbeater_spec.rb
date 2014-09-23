require 'spec_helper'
require 'heartbeat_abril/heartbeater'

describe HeartbeatAbril::Heartbeater do
  let(:file_path) { "#{File.dirname(__FILE__)}/support/heartbeat_example.yml" }
  let(:response) { [api_success_response, api_not_found_response, api_wrong_url_response] }

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

  subject { described_class.new(file_path) }

  describe "#rest_run!" do
    it "returns the status codes" do
      expect(subject.rest_run!).to eql(response)
    end
  end

  describe "#run!" do
    it "returns the status codes" do
      expect(subject.run!).to eql(response)
    end
  end
end
