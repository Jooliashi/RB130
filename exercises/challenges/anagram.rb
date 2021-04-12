=begin
a program that takes a word and a list of anagrams
and select the correct ones from the list
constructor takes a string
match method takes an argument as an array and return a new array with selected ones
=end

class Anagram
  def initialize(str)
    @str = str.downcase
  end

  def match(arr)
    chars = @str.chars.sort
    arr.select do |ana|
      ana.downcase.chars.sort == chars && ana.downcase != @str
    end
  end
end

