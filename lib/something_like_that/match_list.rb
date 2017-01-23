module SomethingLikeThat
  # A list of MatchTokens corresponding to each token in the given Query phrase.
  # Each element is the corresponding Query token's highest-scoring match from
  # the candidate MatchPhrase.
  class MatchList < Array
    def initialize(query, candidate)
      super(query.length)
      @this_phrase = query
      @that_phrase = candidate
      find_matches until none?(&:nil?)
    end

    private

    def find_matches
      @this_phrase.each.with_index do |this_token, i|
        next unless self[i].nil?
        that_token = this_token.best_match_in(@that_phrase)
        next unless that_token.is_a?(NilToken) or 
                    this_token == that_token.best_match_in(@this_phrase)
        self[i] = that_token
        @that_phrase.delete_once(that_token)
      end
    end
  end
end
