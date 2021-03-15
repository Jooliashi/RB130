def max_by(arr)
  largest_value = nil
  max_element = nil
  arr.each_with_index do |ele, idx|
    if largest_value == nil || largest_value < yield(ele)
      largest_value = yield(ele) 
      max_element = ele
    end
  end
  max_element
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil