def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end

def bubble_sort2!(array)
  loop do
    swapped = false
    array_new = array.map { |ele| yield(ele) }
    1.upto(array.size - 1) do |index|
      next if array_new[index - 1] <= array_new[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end


array = %w(sue Pete alice Tyler rachel Kim bonnie)
bubble_sort2!(array) { |value| value.downcase }
p array == %w(alice bonnie Kim Pete rachel sue Tyler)