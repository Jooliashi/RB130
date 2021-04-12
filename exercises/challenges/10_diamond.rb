=begin
take a letter, create a diamond that starts with A all the way up to the letter as the widest point
if C, number of rows = 5, middle row 3
first row A
second row B + space + B
third row C + 3 space + C
if E, number of rows = 9, 2 * E - A - 1
space in the order of 0, 3, 5, 7, 9
class method make_diamond(letter)
final answer should be a string

class Diamond
  def self.make_diamond(letter)
    range = ('A'..letter).to_a + ('A...letter').to_a.reverse
    diamond_width = max_width(letter)

    range.each_with_object([]) do |let, arr|
      arr << make_row(let).center(diamond_width)
    end.join("\n") + "\n"
  end

  private

  def self.make_row(letter)
    return "A" if letter == 'A'
    return "B B" if letter == 'B'

    letter + determine_spaces(letter) + letter
  end

=end

class Diamond
  def self.make_diamond(letter)
    mid_row = letter.ord - 'A'.ord
    diamond = []
    diamond << first_char(mid_row)
    diamond.concat(upper_diamond(mid_row))
           .concat(diamond[0..-2].reverse)
           .join("\n") + "\n"
  end

  class << self
    private

    def first_char(mid_row)
      "A".center(max_width(mid_row))
    end

    def upper_diamond(mid_row)
      diamond_width = max_width(mid_row)
      upper_diamond = []
      1.upto(mid_row) do |row|
        upper_diamond << current_row(row).center(diamond_width)
      end
      upper_diamond
    end

    def current_row(row)
      chars = (65 + row).chr * 2
      chars.insert(1, determine_spaces(row))
    end

    def max_width(mid_row)
      mid_row * 2 + 1
    end

    def determine_spaces(row)
      ' ' * (row * 2 - 1)
    end
  end
end

puts Diamond.make_diamond('C')