def each(array)
  counter = 0

  while counter < array.size
    yield(array[counter])
    counter += 1
  end

  array
end

each([2,3,4]) do |num|
  puts num
end