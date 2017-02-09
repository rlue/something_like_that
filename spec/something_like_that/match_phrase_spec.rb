RSpec.describe SomethingLikeThat::MatchPhrase do
  let :input_string { "Never say never again" }
  let :match_phrase { described_class.new(input_string) }

  describe '#new' do
    it 'tokenizes the input string as an array' do
      expect(match_phrase.length).to eq(4)
    end
  end

  describe '#to_s' do
    it 'returns the original input string' do
      expect(match_phrase.to_s).to eq(input_string)
    end
  end

  describe '#delete_once' do
    it 'removes only one instance of a recurring token' do
      match_phrase.delete_once(SomethingLikeThat::MatchToken.new('never'))
      expect(match_phrase.length).to eq(3)
    end
  end

  describe '#restore' do
    it 'restores all deleted tokens' do
      match_phrase.delete_once(SomethingLikeThat::MatchToken.new('never'))
      match_phrase.restore
      expect(match_phrase.length).to eq(4)
    end
  end
end
