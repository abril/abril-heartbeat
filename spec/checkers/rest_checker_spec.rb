require 'spec_helper'

describe AbrilHeartbeat::RestChecker do
  let(:response) {{ "REST" => [build(:api_success), build(:api_not_found), build(:api_wrong_url)] }}

  let(:input_hash) do
    {
        "api_success"   => { "url" => "http://www.scudelletti.com", "type" => "rest" },
        "api_not_found" => { "url" => "http://www.scudelletti.com/not_found", "type" => "rest" },
        "api_wrong_url" => { "url" => "I am a wrong url", "type" => "rest" }
    }
  end

  before { allow(AbrilHeartbeat::ConfigLoader).to receive(:load) { input_hash } }

  it_behaves_like "a checker" do
    let(:response) {{ "MODEL" => [{"api_success"=>{"url"=>"http://www.scudelletti.com", "status"=>"OK", "status_message"=>"Everything is OK"}}, {"api_not_found"=>{"url"=>"http://www.scudelletti.com/not_found", "status"=>"OK", "status_message"=>"Everything is OK"}}, {"api_wrong_url"=>{"url"=>"I am a wrong url", "status"=>"OK", "status_message"=>"Everything is OK"}}] }}
  end

  describe "#is_running?" do
    context "when there is rest calls" do
      subject { described_class.is_running? }

      it { is_expected.to be_truthy }
    end

    context "when there is not rest calls" do
      before { allow(AbrilHeartbeat::ConfigLoader).to receive(:load) { {} } }

      subject { described_class.is_running? }

      it { is_expected.to be_falsy }
    end
  end
end
