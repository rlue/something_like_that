module SomethingLikeThat
  # Instances of this class are added to MatchList if no matches above the
  # specified threshold are found when calling MatchToken#best_match_in.
  class NilToken < MatchToken
    def initialize
      super ''
    end

    def score
      0
    end
  end
end
