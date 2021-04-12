=begin
scrabble constructor takes a string
method score calculates the score
if the str contains non letter then the score is zero
=end

class Scrabble
  attr_reader :word
  
  SCORE = { ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'] => 1,
            ['D', 'G'] => 2,
            ['B', 'C', 'M', 'P'] => 3,
            ['F', 'H', 'V', 'W', 'Y'] => 4,
            ['K'] => 5,
            ['J', 'X'] => 8,
            ['Q', 'Z'] => 10
          }

  def initialize(word)
    @word = word
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  def score
    return 0 unless valid?
    sum = 0
    word.upcase.chars.each do |char|
      SCORE.each do |key, value|
        sum += value if key.include?char
      end
    end
    sum
  end

  private

  def valid?
    !word.nil? && !word.match(/[^A-Za-z]/)
  end
end