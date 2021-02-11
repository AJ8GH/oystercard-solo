describe Oystercard do
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
      before { subject.top_up(10); subject.touch_in }
      it { is_expected.to be_in_journey }
    end

    context 'when balance is less than minimum fare' do
      it 'raises error' do
        expect { subject.touch_in }.to raise_error LowBalanceError
      end
    end
  end

  describe '#touch_out' do
    context 'after touching in then touching out' do
      before {
        subject.top_up(10)
        subject.touch_in
        subject.touch_out
      }
      it { is_expected.not_to be_in_journey }

      it 'deducts minimum fare from balance' do
        expect{ subject.touch_out }.to change {
          subject.balance
        }.by(-described_class::MINIMUM_FARE)
      end
    end
  end

  # private
  describe '#deduct' do
    before { subject.top_up(1) }

    context 'when deducting 1' do
      it 'removes 1 from balance' do
        subject.send(:deduct, 1)
        expect(subject.balance).to be_zero
      end
    end
  end
end
