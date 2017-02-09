module SomethingLikeThat
  # Stores a string as an array of words (MatchTokens).
  # Can be compared to Queries to generate a similarity score.
  # Queries may be abbreviated/truncated; MatchPhrases should be complete.
  class MatchPhrase < Array
    attr_reader :phrase

    def initialize(phrase)
      @phrase = phrase
      super tokens
    end

    def to_s
      phrase
    end

    def delete_once(token)
      delete_at(index(token)) unless index(token).nil?
    end

    def restore
      clear
      concat tokens
    end

    private

    # TODO: lump determiners and prepositions in with their subjects?
    def tokens
      words.map { |word| MatchToken.new(word, self) }
    end

    def words
      phrase.split(/[^\w']/).reject(&:empty?)
    end
  end
end
