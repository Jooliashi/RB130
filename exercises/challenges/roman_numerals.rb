=begin
problems:
create a class, its constructor takes one integer and convert it to roman numeral number
general rules start with the largest decimal
since the largest number is 3000 in roman 
for single digit, 1,2,3 5 has direct number
for more 10s just add up X up to 40
40 again is special, 50 up is similar pattern with L
hundred is C
D is 500
M is 1000
general pattern is any digit, 1-3 one pattern, 4 one pattern, 5 and up one pattern
2008, take divmod(1000), thous = 2 rest = 8
hundr = 0 rest = 8
tenth = 0 rest = 8
=end

class RomanNumeral
  ROMANS = { 0 => ["I", "V", "X"], 
             1 => ["X", "L", "C"], 
             2 => ["C", "D", "M"], 
             3 => ["M"] }

  def initialize(int)
    @int = int
  end

  def to_roman
    digits = @int.digits
    digits.map.with_index { |x, idx| digit_to_roman(x, idx) }.reverse.join
  end

  def digit_to_roman(num, idx)
    romans = ROMANS[idx]

    case num
    when 1..3 then romans[0] * num
    when 4    then romans[0] + romans[1]
    when 5..8 then romans[1] + romans[0] * (num - 5)
    when 9    then romans[0] + romans[2]
    else           ""
    end
  end
end
