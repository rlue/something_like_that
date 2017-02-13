require 'bundler'
Bundler.setup

require 'something_like_that/match_phrase'
require 'something_like_that/match_phrase/query'
require 'something_like_that/scorer'
require 'something_like_that/nd_array'

# This module encapsulates the entire Something Like That gem, and contains a
# top-level wrapper method to provide a simplified public interface.
module SomethingLikeThat
  def self.new(phrase)
    Query.new(phrase)
  end
end
