require './lib/game.rb'

RSpec.describe Words do
  let(:sentence) { Words.new }
  describe '#add' do
    it 'adds a word to the new class' do
      sentence.add('hello')
      expect(sentence.check('hello')).to eql(true)
    end
  end
  describe '#check' do
    it 'returns true if the word is in the hash' do
      sentence.add('good')
      expect(sentence.check('good')).to eql(true)
    end
    it 'returns false if the word is not in the hash' do
      expect(sentence.check('bad')).to eql(false)
    end
  end
end
