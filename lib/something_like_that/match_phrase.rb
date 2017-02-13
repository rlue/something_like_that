module SomethingLikeThat
  # Holds a string phrase for a Query to be compared to.
  class MatchPhrase < String
    # TODO: lump determiners and prepositions in with their subjects?
    # if so, then must create MatchToken class
    def tokens
      downcase.split(/[^\w']/).reject(&:empty?)
    end
  end
end
