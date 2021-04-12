=begin
create a class with initialize method that takes three sides
invalid triangle should throw an error upon initialization
valid triangle has method kind which should return which type of triangle it was

Test cases:
a constructor that accepts three sides
if any side is not an integer bigger than 0, throws an error
if any two sides addition is not bigger than the third side then raise an exception

data structure:
array to collect sides
integer
return value is a string
=end

class Triangle
  attr_reader :sides

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    raise ArgumentError.new, 'The triangle is invalid' unless valid?
  end

  def kind
    case @sides.uniq.size
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    else        'scalene'
    end
  end

  private

  def valid?
    true unless any_sides_negative? || any_two_sides_smaller_than_one?
  end

  def any_sides_negative?
    @sides.min <= 0
  end

  def any_two_sides_smaller_than_one?
    @sides.combination(2).to_a.map(&:sum).each do |side_sum|
      return true if side_sum <= @sides.sum - side_sum
    end
    false
  end
end
