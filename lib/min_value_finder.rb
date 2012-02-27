class MinValueFinder
  def initialize(function)
    @function = function
  end

  def min_on(range)
    range.inject([]) do |results, value|
      results << Thread.new { @function.call(value) }
    end.map(&:value).min
  end
end
