RSpec.describe SomethingLikeThat::Query do
  let(:test_query) { described_class.new('Harry Potter') }

  describe '#match' do
    it 'handles identical strings' do
      expect(test_query.match('Harry Potter')).to eq(1)
    end

    it 'is case-insensitive' do
      expect(test_query.match('harry potter')).to eq(1)
    end

    it 'ignores order' do
      expect(test_query.match('Potter Harry')).to eq(1)
    end

    it 'averages (p=2) individual Jaro-Winkler scores' do
      expect(test_query.match('Marry Potner')).to be_within(0.001).of(0.895)
    end

    it 'ignores additional words' do
      expect(test_query.match('Harry Potter and the Goblet of Fire')).to eq(1)
    end
  end

  describe '#match?' do
    it 'spots identical strings' do
      expect(test_query.match?('Harry Potter')).to be(true)
    end

    it 'spots similar strings' do
      expect(test_query.match?('Hairy Poster')).to be(true)
    end

    it 'spots dissimilar strings' do
      expect(test_query.match?('Hurdy Gurdy')).to be(false)
    end
  end
end
