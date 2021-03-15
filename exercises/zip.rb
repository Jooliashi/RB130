def zip(arr1, arr2)
  new_array = []
  arr1.each_with_index do |ele, idx|
    new_array << [ele, arr2[idx]]
  end
  new_array
end

p zip([1, 2, 3], [4, 5, 6])
