require 'spec_helper'

describe HeartbeatAbril::Heartbeater do
  let(:file_path) { "#{File.dirname(__FILE__)}/support/heartbeat_example.yml" }

  subject { described_class.new(file_path) }

  before do
    allow(HeartbeatAbril::RestChecker).to receive(:run!) { {"REST" => "MOCK"} }
    allow(HeartbeatAbril::MongoChecker).to receive(:run!) { {"MONGO" => "MOCK"} }
  end

  describe "#run!" do
    context "when the app has more than one dependency" do
      before do
        allow(HeartbeatAbril::RestChecker).to receive(:app_has_rest_calls?) { true }
        allow(HeartbeatAbril::MongoChecker).to receive(:app_has_mongo?) { true }
      end

      it "returns the status codes" do
        expect(subject.run!).to eql([{"REST" => "MOCK"}, {"MONGO" => "MOCK"}])
      end
    end

    context "when the app just have on kind of dependency" do
      before do
        allow(HeartbeatAbril::RestChecker).to receive(:app_has_rest_calls?) { false }
        allow(HeartbeatAbril::MongoChecker).to receive(:app_has_mongo?) { true }
      end

      it "returns the status codes" do
        expect(subject.run!).to eql([{"MONGO" => "MOCK"}])
      end
    end
  end
end
