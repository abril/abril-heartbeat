RSpec.shared_examples "a checker" do
  let(:response) {{ "MODEL" => {"status"=>"OK", "status_message"=>"Everything is OK"} }}

  subject{ described_class }

  it { is_expected.to respond_to(:is_running?) }
  it { is_expected.to respond_to(:module_name) }
  it { is_expected.to respond_to(:run!) }
  it { is_expected.to respond_to(:check!) }

  describe "#run!" do
    before do
      allow(described_class).to receive(:module_name) { "MODEL" }
      allow(described_class).to receive(:check!) { ["OK", "Everything is OK"] }
    end

    subject { described_class.run! }

    it { is_expected.to eql(response) }
  end
end
