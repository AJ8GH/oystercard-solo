describe Journey do

  let(:entry_station) { instance_double(Station, name: :brixton, zone: 2) }
  let(:exit_station) { instance_double(Station, name: :soho, zone: 1) }

  subject {
    described_class.new(
    entry_station: entry_station,
    exit_station: exit_station)
  }

  describe '#initialize' do
    context 'when initialized with 2 stations' do
      it { is_expected.to be_complete }
    end

    context 'when initialized without entry station' do
      subject { described_class.new(exit_station: exit_station) }
      it { is_expected.not_to be_complete }
    end

    context 'when initialized without exit station' do
      subject { described_class.new(entry_station: entry_station) }
      it { is_expected.not_to be_complete }
    end
  end

  describe '#fare' do
    context 'when complete' do
      it 'charges minimum fare' do
        expect(subject.fare).to be(Fares::MINIMUM_FARE)
      end
    end

    context 'when incomplete' do
      subject { described_class.new(entry_station: entry_station) }
      it 'charges penalty fare' do
        expect(subject.fare).to be(Fares::PENALTY_FARE)
      end
    end
  end

  describe '#exit_station' do
    it 'can be update on touch out' do
      subject.exit_station = exit_station
      expect(subject.exit_station).to be exit_station
    end
  end
end
