require './lib/sum.rb'

RSpec.describe Sum do
  let(:number) { Sum.new }
  it 'initialize with a variable called number with 0 as a value' do
    expect(number.total).to eql(0)
  end
  describe '#add' do
    it 'adds a number to the total sum' do
      number.add(5)
      expect(number.total).to eql(5)
    end
  end
  describe '#check' do
    it 'returns the total of the sum' do
        number.add(5)
        number.add(9)
        expect(number.total).to eql(14)
    end
  end
end
