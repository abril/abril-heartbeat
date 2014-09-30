require 'spec_helper'

describe AbrilHeartbeat::Heartbeater do
  let(:file_path) { "#{File.dirname(__FILE__)}/support/heartbeat_example.yml" }

  before do
    allow(AbrilHeartbeat::RestChecker).to receive(:run!) { {"REST" => "MOCK"} }
    allow(AbrilHeartbeat::MongoChecker).to receive(:run!) { {"MONGO" => "MOCK"} }
  end

  describe "#run!" do
    describe "Default checkers" do
      subject { described_class.new({file_path: file_path}).run! }

      context "when the app has more than one dependency" do
        before do
          allow(AbrilHeartbeat::RestChecker).to receive(:running?) { true }
          allow(AbrilHeartbeat::MongoChecker).to receive(:running?) { true }
        end

        it { is_expected.to eql([{"REST" => "MOCK"}, {"MONGO" => "MOCK"}]) }
      end

      context "when the app just have on kind of dependency" do
        before do
          allow(AbrilHeartbeat::RestChecker).to receive(:running?) { false }
          allow(AbrilHeartbeat::MongoChecker).to receive(:running?) { true }
        end

        it { is_expected.to eql([{"MONGO" => "MOCK"}]) }
      end
    end

    describe "Custom checkers" do
      let(:custom_checker) { double("CustomChecker", running?: true) }

      subject { described_class.new({file_path: file_path, custom_checkers: [custom_checker]}) }

      before do
        allow(AbrilHeartbeat::RestChecker).to receive(:running?) { false }
        allow(AbrilHeartbeat::MongoChecker).to receive(:running?) { false }
        allow(AbrilHeartbeat::MysqlChecker).to receive(:running?) { false }
      end

      it "returns the status codes" do
        expect(custom_checker).to receive(:running?)
        expect(custom_checker).to receive(:run!)

        subject.run!
      end
    end
  end
end
