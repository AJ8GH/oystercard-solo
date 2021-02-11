describe Station do
  context 'when initialized' do
    subject { described_class.new(name: :brixton, zone: 2) }
    it 'has a zone' do
      expect(subject.zone).to be 2
    end

    it 'has a name' do
      expect(subject.name).to be :brixton
    end
  end
end
