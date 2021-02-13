describe JourneyLog do
  let(:journey_class) { class_double(Journey, :journey_class, new: new_journey) }
  let(:entry_station) { instance_double(Station, :entry_station, name: :brixton, zone: 2) }
  let(:exit_station) { instance_double(Station, :entry_station, name: :soho, zone: 1) }

  let(:new_journey) {
    instance_double(
      Journey, :journey,
      entry_station: entry_station,
      exit_station: exit_station,
      :exit_station= => exit_station
    ) }

  let(:complete_journey) {
    instance_double(Journey, :journey, entry_station: entry_station, exit_station: exit_station)
  }

  subject { described_class.new(journey_class) }

  describe '#start' do
    it 'creates journey with entry_station' do
      subject.start(entry_station)
      expect(subject.current_journey).to be new_journey
    end
  end

  describe '#journeys' do
    it 'shows the journey history' do
      expect(subject.journeys).to eq []
    end
  end

  describe '#finish' do
    context 'after touch in and touch out' do
      it 'adds exit station to current journey' do
        subject.start(entry_station); subject.finish(exit_station)
        expect(subject.journeys.last.exit_station).to be exit_station
      end
    end

    context 'after forgetting to touch in' do
      xit 'creates a new incomplete journey' do
        expect(subject)
      end
    end
  end
end
