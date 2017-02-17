module SomethingLikeThat
  # Holds a string phrase to be compared to other (candidate) MatchPhrases.
  # Queries may be abbreviated/truncated; candidates should be complete.
  class Query < MatchPhrase
    attr_reader :scorer

    def initialize(phrase)
      super phrase
      @scorer = Scorer.new(self)
    end

    def match(candidate)
      scorer.score(MatchPhrase.new(candidate))
    end

    def match?(candidate)
      scorer.match?(MatchPhrase.new(candidate))
    end
  end
end
