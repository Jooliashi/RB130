=begin
reduce method
accumulate collection into one object
yielding each element to the block, the return value of the block is saved as the new object
=end

def reduce(array, memo = nil)
  counter = 0
  if memo.nil?
    memo = array[0]
    counter += 1
  end

  while counter < array.size
    memo = yield(memo, array[counter])
    counter += 1
  end

  memo
end

array = [1, 2, 3, 4, 5]

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']