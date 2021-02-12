describe Oystercard do
  let(:entry_station) { double(:entry_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey_class) { class_double(Journey, :journey_class, new: journey) }

  subject { described_class.new(journey_class) }

  let(:journey) do instance_double(
    Journey, :journey,
    entry_station: entry_station,
    exit_station: exit_station,
    :exit_station= => exit_station
  )
  end

  describe '#balance' do
    context 'when initialized' do
      subject { described_class.new.balance }
      it { is_expected.to be_zero }
    end
  end

  describe '#top_up' do
    context 'when topping up 1' do
      it 'adds 1 to balance' do
        subject.top_up(1)
        expect(subject.balance).to be 1
      end
    end

    context 'when topping up 15' do
      it 'adds 15 to balance' do
        subject.top_up(15)
        expect(subject.balance).to be 15
      end
    end

    context 'when balance goes over limit' do
      it 'raises error' do
        expect {
          subject.top_up(described_class::MAX_BALANCE + 1)
        }.to raise_error MaxBalanceError
      end
    end
  end

  describe '#touch_in' do
    context 'after touching in' do
      it 'starts a new journey' do
        subject.top_up(10); subject.touch_in(entry_station)
        expect(subject.journeys.last).to be journey
      end
    end

    context 'when balance is less than minimum fare' do
      it 'raises error' do
        expect {
          subject.touch_in(entry_station)
        }.to raise_error LowBalanceError
      end
    end
  end

  describe '#touch_out' do
    before { subject.top_up(10) }

    context 'after touching in then touching out' do
      it 'deducts minimum fare from balance' do
        subject.touch_in(entry_station)
        expect{ subject.touch_out(exit_station) }.to change {
          subject.balance
        }.by(-described_class::MINIMUM_FARE)
      end
    end

    context 'when traveller forgot to touch in' do
      it 'adds a new journey to journeys' do
        expect {
          subject.touch_out(exit_station)
        }.to change { subject.journeys.count }.by 1
      end
    end
  end

  describe '#journeys' do
    context 'when initialized' do
      it 'is empty' do
        expect(subject.journeys).to be_empty
      end
    end

    context 'after 1 journey' do
      before {
        subject.top_up(10)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
      }

      it 'stores the journey' do
        expect(subject.journeys).to_not be_empty
      end

      it 'stores the correct journey' do
        expect(subject.journeys).to include(journey)
      end
    end
  end
end
