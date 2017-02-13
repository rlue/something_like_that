require 'ostruct'

module SomethingLikeThat
  # Holds a 2-dimensional numeric array.
  # Unstable. We're holding out for a better numeric array library...
  class TwoDArray < Array
    def initialize(array)
      super array
    end

    # TODO: rename (incl. corresponding method call in Scorer)
    def maxima
      max_vals = Array.new(length)
      double = dup
      max_vals.map.with_index { |_, i| i < lengths.min ? double.pop_max : 0 }
    end

    def pop_max
      max = flatten.max
      eliminate(coords(max))
      max
    end

    def lengths
      x = length
      y = map(&:length).max
      min, max = [x, y].minmax
      OpenStruct.new(x: x, y: y, min: min, max: max)
    end

    private

    def eliminate(axes)
      delete_at(axes.x)
      each { |row| row.delete_at(axes.y) }
    end

    def coords(value)
      x = index { |row| row.include?(value) }
      y = slice(x).index(value)
      OpenStruct.new(x: x, y: y)
    end
  end
end
