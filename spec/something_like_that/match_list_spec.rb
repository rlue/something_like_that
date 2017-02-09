RSpec.describe SomethingLikeThat::MatchList do
  let(:query) do
    SomethingLikeThat::Query.new('Good Eats')
  end
  let(:candidates) do
    [SomethingLikeThat::MatchPhrase.new('Good Eats'),
     SomethingLikeThat::MatchPhrase.new('Good Grief'),
     SomethingLikeThat::MatchPhrase.new('East of Eden'),
     SomethingLikeThat::MatchPhrase.new('City of God')]
  end
  let(:match_lists) do
    candidates.map { |cnd| described_class.new(query, cnd) }
  end

  describe '#new' do
    it 'is exactly as long as the Query phrase' do
      expect(match_lists.map(&:length).uniq.length).to eq(1)
      expect(match_lists.map(&:length).uniq[0]).to eq(query.length)
    end

    it 'populates itself' do
      expect(match_lists[0][0].to_s).to eq('good')
      expect(match_lists[0][1].to_s).to eq('eats')
      expect(match_lists[1][0].to_s).to eq('good')
      expect(match_lists[2][1].to_s).to eq('east')
      expect(match_lists[3][0].to_s).to eq('god')
    end

    context 'when no matches above threshold found' do
      it 'assigns NilTokens' do
        expect(match_lists[1][1]).to be_a(SomethingLikeThat::NilToken)
        expect(match_lists[2][0]).to be_a(SomethingLikeThat::NilToken)
        expect(match_lists[3][1]).to be_a(SomethingLikeThat::NilToken)
      end
    end

    it 'only includes matches above the threshold' do
      query.each do |this_token|
        match_lists.each do |match_list|
          match_list.each do |that_token|
            expect(this_token.score(that_token)).
              not_to be_between(0, SomethingLikeThat::MatchToken.threshold).
                exclusive
          end
        end
      end
    end
  end
end
