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

  describe '#end_journey' do
    subject { described_class.new(entry_station: entry_station) }

    it 'updates exit station' do
      subject.end_journey(exit_station)
      expect(subject.exit_station).to be exit_station
    end
  end

  describe '#start_journey' do
    subject { described_class.start_journey(entry_station) }

    it 'creates a journey with an entry_station' do
      expect(subject.entry_station).to be entry_station
    end

    it 'creates a journey with no exit_station' do
      expect(subject.exit_station).to be_nil
    end
  end

  describe '#new_incomplete' do
    subject { described_class.new_incomplete(exit_station) }

    it 'creates a new journey with no entry station' do
      expect(subject.entry_station).to be nil
    end
  end
end
