module SomethingLikeThat
  # For individual words in match phrases
  # TODO: add flag if word is common
  class MatchToken
    @@threshold = 0.8

    class << self
      def threshold
        @@threshold
      end

      def threshold=(value)
        @@threshold = value
      end
    end

    def initialize(word)
      @word     = word
      @amatcher = Amatch::JaroWinkler.new(word)
    end

    def to_s
      @word
    end

    def best_match_in(match_phrase)
      winner = match_phrase.max_by { |match_token| score(match_token) }
      score(winner) > @@threshold ? winner : NilToken.new
    end

    def score(match_token)
      return 0 if match_token.is_a?(NilToken)
      @amatcher.match(match_token.to_s)
    end
  end
end
