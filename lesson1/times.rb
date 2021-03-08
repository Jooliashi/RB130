def times(number)
  counter = 0
  while counter < number do
    yield(counter)
    counter += 1
  end
  
  number
end

times(5) do |num|
  puts num
end

=begin
on line `11`, method times is called with an integer object `5` passed to it as an argument and a block of code
on line `3`, a local variable is initialized to an integer object `0`
on line `4`, `while` conditional is evaluated to `true`
on line `5`, it yields to the block with object pointed to by variable `counter` passed to it as an argument
on line `11`, object pointed to by counter is assigned to the block's local variable `num`
on line `12`, it outputs the block local variable `num`
on line `5`, `counter` is incremented
upon line `6`, the end of `while` loop, execution comes back to line `3` and repeats
at some point, the `while` conditional evaluates to `false` and goes to line `8`
on line `9` the method ends and returns the last line of code which is `number`
=end