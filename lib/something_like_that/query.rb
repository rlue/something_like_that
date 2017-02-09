module SomethingLikeThat
  # The principal object class of the SomethingLikeThat gem.
  # Instances of this class can be compared against complete,
  # multi-word phrases (of parent class MatchPhrase)
  # to be scored for similarity.
  class Query < MatchPhrase
    attr_reader :candidate

    def initialize(phrase)
      @match_list = []
      super phrase
    end

    def match(phrase)
      @candidate = MatchPhrase.new(phrase)
      Score.calculate(self, match_list)
    end

    private
    
    # TODO: find a way to reset @match_list on subsequent calls...
    def match_list
      (restore; return @match_list) if empty?
      match = shift.best_match_in(candidate, :bidirectional)
      match_list.push(match)
      candidate.delete_once(match)
    end
  end
end
