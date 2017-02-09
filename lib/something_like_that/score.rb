module SomethingLikeThat
  class Score
    class << self
      DEFAULT_MEAN_POWER = 2
      attr_reader :query, :match_list

      def calculate(query, match_list)
        @query = query
        @match_list = match_list
        generalized_mean(scores)
      end

      private

      def scores
        [query, match_list].transpose.map { |token, match| token.score(match) }
      end

      def generalized_mean(numbers, p=DEFAULT_MEAN_POWER)
        (numbers.map { |x| x**p }.reduce(:+).to_f / numbers.length) ** (1.0/p)
      end
    end
  end
end
