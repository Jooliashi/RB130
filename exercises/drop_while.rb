def drop_while(arr)
  idx = 0
  while idx < arr.size
    break unless yield(arr[idx])
    idx += 1
  end
  arr[idx..-1]
end


p drop_while([1, 3, 5, 6]) { |value| value.odd? } 
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []