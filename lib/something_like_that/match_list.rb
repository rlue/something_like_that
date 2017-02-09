module SomethingLikeThat
  # A list of MatchTokens corresponding to each token in the given Query phrase.
  # Each element is the corresponding Query token's highest-scoring match from
  # the candidate MatchPhrase.
  # TODO: Integrate whole class into Query?
  class MatchList < Array
    attr_reader :query, :this_phrase, :that_phrase

    def initialize(query, candidate)
      super(query.length)
      @query = query
      @this_phrase = query.dup
      @that_phrase = candidate
      find_matches until none?(&:nil?)
    end

    private

    def find_matches
      query.map { |this_token| this_token.find_match_in(that_phrase) }
    end
  end
end
