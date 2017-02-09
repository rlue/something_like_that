RSpec.describe SomethingLikeThat::MatchToken do
  let(:match_phrase) { SomethingLikeThat::MatchPhrase.new('The thy they then') }
  let(:match_tokens) { %w(THE? thy they then).map do |word| 
                         SomethingLikeThat::MatchToken.new(word) 
                       end }

  describe '#new' do
    it 'instantiates a formatted string' do
      expect(match_tokens.first).to eq('the')
    end
  end

  describe '#best_match_in' do
    it 'finds the best match' do
      expect(match_tokens[0].best_match_in(match_phrase).to_s).to eq('the')
      expect(match_tokens[1].best_match_in(match_phrase).to_s).to eq('thy')
      expect(match_tokens[2].best_match_in(match_phrase).to_s).to eq('they')
      expect(match_tokens[3].best_match_in(match_phrase).to_s).to eq('then')
    end
  end

  describe '#score' do
    it 'computes Jaro-Winkler score' do
      expect(match_tokens[0].score(match_tokens[0])).to eq(1)
      expect(match_tokens[0].score(match_tokens[1])).to be_within(0.01).of(0.82)
      expect(match_tokens[0].score(match_tokens[2])).to be_within(0.01).of(0.94)
      expect(match_tokens[0].score(match_tokens[3])).to be_within(0.01).of(0.94)
    end
  end
end
