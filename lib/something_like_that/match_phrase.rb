module SomethingLikeThat
  # This library performs fuzzy string comparison _asymmetrically_.
  # Queries (subclass of this class) may be short/abbreviated/truncated;
  # MatchPhrases should be complete.
  class MatchPhrase < Array
    def initialize(phrase)
      super tokenize(phrase.downcase)
      @phrase = phrase
    end

    def to_s
      @phrase
    end

    def delete_once(token)
      delete_at(index(token)) unless index(token).nil?
    end

    private

    # TODO: clean up all non-word characters
    def tokenize(phrase)
      phrase.split(/[^\w']/).map { |word| MatchToken.new(word) }
    end
  end
end
