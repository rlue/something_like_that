RSpec.describe SomethingLikeThat::Query do
  let(:query_string) { 'good bad ugly' }
  let(:query) { SomethingLikeThat::Query.new(query_string) }

  describe '#match' do
    context 'with identical candidates' do
      it 'returns 1' do
        expect(query.match(query_string)).to eq(1)
      end

      it 'is case-insensitive' do
        expect(query.match(query_string.upcase)).to eq(1)
      end
    end

    context 'with extraneous words' do
      it 'still returns 1' do
        expect(query.match('The Good, the Bad, and the Ugly')).to eq(1)
      end
    end

    context 'with typos' do
      it 'accepts matches above the threshold' do
        expect(query.match('Ugly, Bad God')).to be > 0.8
      end
    end
  end
end
