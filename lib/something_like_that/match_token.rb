module SomethingLikeThat
  # For comparing individual words in match phrases
  class MatchToken < String
    class << self; attr_accessor :threshold end
    attr_reader :jaro_winkler, :parent_phrase

    DEFAULT_THRESHOLD = 0.8
    @threshold = DEFAULT_THRESHOLD

    def initialize(word, parent_phrase='')
      super format(word)
      @jaro_winkler  = Amatch::JaroWinkler.new(self)
      @parent_phrase = parent_phrase.dup
    end

    def best_match_in(match_phrase, bidirectional=false)
      match = match_phrase.max_by { |match_token| score(match_token) }
      if bidirectional && this_token != that_token.best_match_in(this_phrase)
        # then what?
        # blacklist that_token and that_token.best_match_in(this_phrase)
        # then best_match_in again
      end
      match?(that_token) ? that_token : MatchToken.new('')
    end

    def score(match_token)
      jaro_winkler.match(match_token)
    end

    private

    def format(word)
      word.downcase.gsub(/[^\w]/, '')
    end

    def match?(match_token)
      score(match_token) > self.class.threshold
    end
  end
end
