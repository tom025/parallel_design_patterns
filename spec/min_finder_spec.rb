require 'timeout'
require_relative '../lib/min_value_finder'

describe MinValueFinder do

  let(:square) { ->(x) { x * x } }

  let(:neg) { ->(x) { -x } }

  let(:slow_neg) { ->(x) { sleep 2; -x } }

  it 'returns the correct value for a range of one element' do
    MinValueFinder.new(square).min_on(-2..-2).should == 4
  end

  it 'finds the minimum result for the square function on the range 2 to 5' do
    MinValueFinder.new(square).min_on(2..5).should == 4
  end

  it 'finds the minimum result for the square funcition on the range -4 to 10' do
    MinValueFinder.new(square).min_on(-4..10).should == 0
  end

  it 'finds the minimum result for the negative function on the range -4 to 10' do
    MinValueFinder.new(neg).min_on(-4..10).should == -10
  end

  it 'completes slow calculations in time' do
    Timeout.timeout(0.8) do
      MinValueFinder.new(slow_neg).min_on(0..10).should == -10
    end
  end

  it 'handles large problems' do
    MinValueFinder.new(slow_neg).min_on(0..6000).should == -6000
  end
end

