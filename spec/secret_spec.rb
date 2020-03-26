require_relative '../lib/secret.rb'

RSpec.describe Words do
  let(:secret) { Secret.new }
  describe '#add' do
    it 'adds a secret phrase with a username and a password' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      expect(secret.check('SpaYco', 'GoodPassword', 'show')).to eql('the secret of life')
    end
    it 'returns false if the username already exist' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      expect(secret.add('SpaYco', 'BadPassword', 'the beauty of life')).to eql(false)
    end
  end
  describe '#check' do
    it 'returns the secret sentence when you input the right username and password' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      expect(secret.check('SpaYco', 'GoodPassword', 'show')).to eql('the secret of life')
    end
    it 'changes the secret sentence if given change as an argument' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      secret.check('SpaYco', 'GoodPassword', 'change', 'i was wrong')
      expect(secret.check('SpaYco', 'GoodPassword', 'show')).to eql('i was wrong')
    end
    it 'returns false if the username or password is wrong' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      expect(secret.check('SpaY', 'GoodPassword', 'show')).to eql(false)
      expect(secret.check('SpaYco', 'BadPassword', 'show')).to eql(false)
    end
  end
  describe '#exist?' do
    it 'returns true if the user exist' do
      secret.add('SpaYco', 'GoodPassword', 'the secret of life')
      expect(secret.exist?('SpaYco')).to eql(true)
    end
    it 'returns false if the user doesn\'t exist' do
      expect(secret.exist?('IDoNotExist')).to eql(false)
    end
  end
end
