class MinValueFinder
  def initialize(function, max_num_of_threads=2040)
    @function = function
    @max_num_of_threads = max_num_of_threads
  end

  def min_on(range)
    sub_solutions = []
    range.each_slice(slice_size_for(range)) do |sub_p|
      sub_solutions << solver(sub_p)
    end
    sub_solutions.map(&:value).min
  end

  private
  def solver(problem)
    Thread.new do
      problem.inject([]) do |results, value|
        results << @function.call(value)
      end.min
    end
  end

  def slice_size_for(problem)
    (range.to_a.size.to_f / @max_num_of_threads.to_f).ceil
  end
end
