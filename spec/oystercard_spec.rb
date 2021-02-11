describe Oystercard do
  describe '#balance' do
    context 'when initialized' do
      it 'is zero' do
        expect(subject.balance).to be_zero
      end
    end

    describe '#top_up' do
      context 'when topping up 1' do
        it 'adds 1 to balance' do
          subject.top_up(1)
          expect(subject.balance).to be 1
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
  end
end
