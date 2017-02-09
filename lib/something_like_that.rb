require 'bundler'
Bundler.setup
require 'amatch'

require 'something_like_that/match_phrase'
require 'something_like_that/query'
require 'something_like_that/match_token'
require 'something_like_that/nil_token'
require 'something_like_that/match_list'
require 'something_like_that/score'

module SomethingLikeThat
  def self.new(phrase, query_class=Query)
    query_class.new(phrase)
  end
end
