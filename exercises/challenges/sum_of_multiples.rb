=begin
a natural number and a set of other numbers
find the sum of all the multiples of set numbers that are less than first number
class method to  and instance method new
new takes set of numbers
to takes one 
=end

class SumOfMultiples
  attr_reader :set
  def initialize(*set)
    @set = set.empty? ? [3, 5] : set
  end

  def to(num)
    sum = []
    set.each do |multiple|
      i = 1
      while i * multiple < num
        sum << multiple * i if !sum.include?(multiple * i)
        i += 1
      end
    end
    sum.sum
  end

  def self.to(num)
    SumOfMultiples.new.to(num)
  end
end
