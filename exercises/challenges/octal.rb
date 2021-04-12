=begin
constructor takes one integer
if invalid number then return 0
=end

class Octal
  attr_reader :str
  def initialize(str)
    @str = str
  end

  def to_decimal
    return 0 if str.match(/[^0-7]/)
    sum = 0
    str.to_i.digits.each_with_index do |digit, idx|
      sum += digit * (8 ** idx)
    end
    sum
  end
end
