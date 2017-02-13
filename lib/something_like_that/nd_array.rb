require 'ostruct'

module SomethingLikeThat
  # Holds an n-dimensional numeric array.
  # Unstable. We're holding out for a better numeric array library...
  class NDArray < Array
    def initialize(array)
      unless array.flatten.all? { |elt| elt.is_a?(Numeric) }
        raise ArgumentError, 'non-numeric values detected'
      end
      super array
    end

    # TODO: rename (incl. corresponding method call in Scorer)
    def maxima
      max_vals = []
      double = dup
      max_vals.push(double.pop_max) until double.empty?
      max_vals
    end

    def pop_max
      max = flatten.max
      eliminate(coords(max))
      max
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
