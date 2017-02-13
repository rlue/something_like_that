require 'amatch'

module SomethingLikeThat
  # Computes similarity scores in asymmetrical comparison of string phrases.
  class Scorer
    @mean_exponent = 2
    @threshold = 0.8
    class << self
      attr_reader :mean_exponent, :threshold

      def mean_exponent=(p)
        unless p.is_a?(Integer)
          raise TypeError, 'mean_exponent must be an integer'
          # TODO: add explanation in rdoc documentation?
        end
        @mean_exponent = p
      end

      def threshold=(threshold)
        unless threshold.between?(0, 1)
          raise RangeError, 'threshold must be between 0 and 1'
          # TODO: add explanation in rdoc documentation?
        end
        @threshold = threshold
      end

      def generalized_mean(numbers, p = mean_exponent)
        (numbers.map { |x| x**p }.reduce(:+).to_f / numbers.length)**(1.0 / p)
      end
    end

    attr_reader :query_matchers

    def initialize(query, matcher = Amatch::JaroWinkler)
      @query_matchers = query.tokens.map { |token| matcher.new(token) }
    end

    def score(candidate)
      average(top_scores(candidate.tokens))
    end

    def match?(candidate)
      score(candidate) > self.class.threshold
    end

    private

    def top_scores(candidate_tokens, max_finder = TwoDArray)
      all_scores = tokenwise_score_table(candidate_tokens)
      max_finder.new(all_scores).maxima
    end

    def tokenwise_score_table(candidate_tokens)
      query_matchers.map do |matcher|
        candidate_tokens.map do |token|
          apply_threshold(matcher.match(token))
        end
      end
    end

    def apply_threshold(score)
      score > self.class.threshold ? score : 0
    end

    def average(scores)
      self.class.generalized_mean(scores)
    end
  end
end
