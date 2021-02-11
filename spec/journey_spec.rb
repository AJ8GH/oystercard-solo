describe Journey do
  let(:entry_station) { instance_double(Station, name: :brixton, zone: 2) }
  let(:exit_station) { instance_double(Station, name: :soho, zone: 1) }

  context 'when initialized with 2 stations' do
    subject { described_class.new(entry_station, exit_station) }
    it { is_expected.to be_complete }
  end
end
