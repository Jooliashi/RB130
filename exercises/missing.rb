def missing(arr)
  new_arr = []
  arr.first.upto(arr.last) do |num|
    if !arr.include?(num)
      new_arr << num
    end
  end
  new_arr
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []