require 'spec_helper'
require 'heartbeat_abril/heartbeater'

describe HeartbeatAbril::Heartbeater do
  let(:file_path) { "#{File.dirname(__FILE__)}/support/heartbeat_example.yml" }
  let(:response)  { [api_success_response, api_not_found_response, api_wrong_url_response] }
  let(:api_success_response)   { build(:api_success) }
  let(:api_not_found_response) { build(:api_not_found) }
  let(:api_wrong_url_response) { build(:api_wrong_url) }

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
