require 'spec_helper'

describe AbrilHeartbeat::MysqlChecker do
  let(:success_response) {{ "MYSQL" => {"status" => "OK", "status_message" => "Everything is under control" }}}
  let(:fail_response)    {{ "MYSQL" => {"status" => "FAIL", "status_message" => "YYYY" }}}

  it_behaves_like "a checker"

  describe "#run!" do
    context "when the mongo is online" do
      before { allow(AbrilHeartbeat::MysqlWrapper).to receive(:check_status!) }

      subject { described_class.run! }

      it { is_expected.to eql(success_response) }
    end

    context "when the mongo offline" do
      before { allow(AbrilHeartbeat::MysqlWrapper).to receive(:check_status!) { raise "YYYY" } }

      subject { described_class.run! }

      it { is_expected.to eql(fail_response) }
    end
  end

  describe "#running?" do
    context "when the app has a mysql client" do
      before { allow(AbrilHeartbeat::MysqlWrapper).to receive(:client?) { "constant" } }

      subject { described_class.running? }

      it { is_expected.to be_truthy }
    end

    context "when the app does not have a mysql client" do
      subject { described_class.running? }

      it { is_expected.to be_falsy }
    end
  end
end
