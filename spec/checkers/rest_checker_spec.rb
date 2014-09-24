require 'spec_helper'
require 'heartbeat_abril/checkers/rest_checker'

describe HeartbeatAbril::RestChecker do
  let(:response) {{ "REST" => [build(:api_success), build(:api_not_found), build(:api_wrong_url)] }}

  let(:input_hash) do
    {
      "api_success"   => { "url" => "http://www.scudelletti.com" },
      "api_not_found" => { "url" => "http://www.scudelletti.com/not_found" },
      "api_wrong_url" => { "url" => "I am a wrong url" }
    }
  end

  describe "#run!" do
    subject { described_class.run!(input_hash) }

    it { is_expected.to eql(response) }
  end

  describe "#is_running??" do
    context "when there is rest calls" do
      subject { described_class.is_running?(input_hash) }

      it { is_expected.to be_truthy }
    end

    context "when there is not rest calls" do
      subject { described_class.is_running?({}) }

      it { is_expected.to be_falsy }
    end
  end
end
