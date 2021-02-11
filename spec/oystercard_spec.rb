describe Oystercard do
  describe '#balance' do
    context 'when initialized' do
      it 'is zero' do
        expect(subject.balance).to be_zero
      end
    end

    describe '#top_up' do
      context 'with argument 1' do
        it 'adds 1 to balance' do
          subject.top_up(1)
          expect(subject.balance).to be 1
        end
      end
    end
  end
end
