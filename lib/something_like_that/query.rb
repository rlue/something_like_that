module SomethingLikeThat
  # The principal object class of the SomethingLikeThat gem.
  # Instances of this class can be compared against complete,
  # multi-word phrases (of parent class MatchPhrase)
  # to be scored for similarity.
  class Query < MatchPhrase
    def initialize(phrase)
      super phrase
    end

    # TODO: handle common words
    def match(phrase)
      candidate  = MatchPhrase.new(phrase)
      match_list = MatchList.new(self, candidate)
      scores     = [self, match_list].transpose.map do |token, match|
                     token.score(match)
                   end
      average(scores)
    end

    # TODO: Implement generalized average
    def average(scores, n=2)
      scores.reduce(:+).to_f / scores.length
    end
  end
end
