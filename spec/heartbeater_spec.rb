require 'spec_helper'

describe HeartbeatAbril::Heartbeater do
  let(:file_path) { "#{File.dirname(__FILE__)}/support/heartbeat_example.yml" }

  before do
    allow(HeartbeatAbril::RestChecker).to receive(:run!) { {"REST" => "MOCK"} }
    allow(HeartbeatAbril::MongoChecker).to receive(:run!) { {"MONGO" => "MOCK"} }
  end

  describe "#run!" do
    describe "Default checkers" do
      subject { described_class.new(file_path) }

      context "when the app has more than one dependency" do
        before do
          allow(HeartbeatAbril::RestChecker).to receive(:is_running?) { true }
          allow(HeartbeatAbril::MongoChecker).to receive(:is_running?) { true }
        end

        it "returns the status codes" do
          expect(subject.run!).to eql([{"REST" => "MOCK"}, {"MONGO" => "MOCK"}])
        end
      end

      context "when the app just have on kind of dependency" do
        before do
          allow(HeartbeatAbril::RestChecker).to receive(:is_running?) { false }
          allow(HeartbeatAbril::MongoChecker).to receive(:is_running?) { true }
        end

        it "returns the status codes" do
          expect(subject.run!).to eql([{"MONGO" => "MOCK"}])
        end
      end
    end

    describe "Custom checkers" do
      let(:custom_checker) { double("CustomChecker", is_running?: true) }

        subject { described_class.new(file_path, {custom_checkers: [custom_checker]}) }

      before do
        allow(HeartbeatAbril::RestChecker).to receive(:is_running?) { false }
        allow(HeartbeatAbril::MongoChecker).to receive(:is_running?) { false }
        allow(HeartbeatAbril::MysqlChecker).to receive(:is_running?) { false }
      end

      it "returns the status codes" do
        expect(custom_checker).to receive(:is_running?)
        expect(custom_checker).to receive(:run!)

        subject.run!
      end
    end
  end
end
