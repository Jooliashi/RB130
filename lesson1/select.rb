=begin
Note that the Array#select method takes a block, then yields each element to the block. 
If the block evaluates to true, the current element will be included in the returned array. 
If the block evaluates to false, the current element will not be included in the returned array.
=end

def select(array)
  counter = 0
  new_array = []

  while counter < array.size
    if yield[array[counter]]
      new_array << array[counter]
    end
    counter += 1
  end

  new_array
end

array = [1, 2, 3, 4, 5]

p array.select { |num| num.odd? }       # => [1, 3, 5]
p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
p array.select { |num| num + 1 }        # =
