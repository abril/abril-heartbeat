require 'spec_helper'

describe HeartbeatAbril::MysqlChecker do
  let(:success_response) {{ "MYSQL" => {"status" => "OK", "status_message" => "Everything is under control" }}}
  let(:fail_response)    {{ "MYSQL" => {"status" => "FAIL", "status_message" => "YYYY" }}}

  describe "#run!" do
    context "when the mongo is online" do
      before { allow(HeartbeatAbril::MysqlWrapper).to receive(:check_status!) }

      subject { described_class.run! }

      it { is_expected.to eql(success_response) }
    end

    context "when the mongo offline" do
      before { allow(HeartbeatAbril::MysqlWrapper).to receive(:check_status!) { raise "YYYY" } }

      subject { described_class.run! }

      it { is_expected.to eql(fail_response) }
    end
  end

  describe "#app_has_mongo?" do
    context "when the app has a mongo client" do
      before { allow(HeartbeatAbril::MysqlWrapper).to receive(:has_client?) { "constant" } }

      subject { described_class.app_has_mysql? }

      it { is_expected.to be_truthy }
    end

    context "when the app does not have a mongo client" do
      subject { described_class.app_has_mysql? }

      it { is_expected.to be_falsy }
    end
  end
end
