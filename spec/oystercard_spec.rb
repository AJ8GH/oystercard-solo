describe Oystercard do
  describe '#balance' do
    context 'when initialized' do
      it 'is zero' do
        expect(subject.balance).to be_zero
      end
    end
  end
end
