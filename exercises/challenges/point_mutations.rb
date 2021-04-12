=begin
problem:
two strands of DNA represented by a string of letters
compare the difference in the sequence of letters
if two strings different length, compare by the short length

test:
constructor - intake a strin gof DNA
method hamming_distance(argument DNA) returning an integer
if empty strings then return 0

data_structure:
strings, possibly arrays if we want to split them and find difference
integers

method hamming_distance
find the shorter strand size
from 0 idx up to the min size, iterate through both strands and count the differences
=end

class DNA
  def initialize(original)
    @strand = original
  end

  def hamming_distance(distance)
    differences = 0
    min = [distance.size, @strand.size].min
    0.upto(min - 1) do |idx|
      differences += 1 if distance[idx] != @strand[idx]
    end
    differences
  end
end
