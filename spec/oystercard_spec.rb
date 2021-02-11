describe Oystercard do
  let(:station) { double(:station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { {entry_station: station, exit_station: exit_station} }

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

  describe '#in_journey' do
    context 'when initialized' do
      it { is_expected.not_to be_in_journey }
    end
  end

  describe '#touch_in' do
    context 'after touching in' do
      before { subject.top_up(10); subject.touch_in(station) }
      it { is_expected.to be_in_journey }

      it 'saves entry station' do
        expect(subject.entry_station).to be station
      end
    end

    context 'when balance is less than minimum fare' do
      it 'raises error' do
        expect { subject.touch_in(station) }.to raise_error LowBalanceError
      end
    end
  end

  describe '#touch_out' do
    context 'after touching in then touching out' do
      before {
        subject.top_up(10)
        subject.touch_in(station)
        subject.touch_out(exit_station)
      }
      it { is_expected.not_to be_in_journey }

      it 'deducts minimum fare from balance' do
        expect{ subject.touch_out(exit_station) }.to change {
          subject.balance
        }.by(-described_class::MINIMUM_FARE)
      end

      it 'resets entry station to nil' do
        expect(subject.entry_station).to be_nil
      end

      it 'saves exit station' do
        expect(subject.exit_station).to be exit_station
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
        subject.touch_in(station)
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
