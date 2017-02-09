RSpec.describe SomethingLikeThat::Query do
  let(:query_string) { 'good bad ugly' }
  let(:query) { SomethingLikeThat::Query.new(query_string) }

  describe '#match' do
    it 'doesn\'t care about order' do
      expect(query.match(query_string)).to eq(query.match('bad ugly good'))
    end

    it 'is case-insensitive' do
      expect(query.match(query_string)).to eq(query.match('GOOD BAD UGLY'))
    end

    it 'ignores words not present in query' do
      expect(query.match(query_string)).
        to eq(query.match('The Good, the Bad, and the Ugly'))
    end

    it 'averages resulting scores' do
      expect(query.match('Ugly Bat God')).to be_within(0.01).of(0.92)
      expect(SomethingLikeThat::Query.new('Lenovo inc').match('Lenovo corp.')).to be_within(0.01).of(0.71)
    end
  end
end
