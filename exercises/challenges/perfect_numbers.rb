=begin
find the sum of a number's divisor excluding number itself and compare it
method classify is a class method that takes a number
if negative number is input then return standarderror
=end

class PerfectNumber
  def self.classify(num)
    sum = 0
    raise StandardError.new unless valid?(num)
    1.upto(num - 1) do |divisor|
      sum += divisor if num % divisor == 0
    end
    match(sum - num)
  end
  class << self
    private
  
    def valid?(num)
      num > 0
    end

    def match(difference)
      if difference < 0
        'deficient'
      elsif difference > 0
        'abundant'
      else
        'perfect'
      end
    end
  end
end
