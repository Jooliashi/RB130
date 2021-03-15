def step(start_value, end_value, step)
  while start_value <= end_value
    yield(start_value)
    start_value += step
  end
  nil
end

step(1, 10, 3) { |value| puts "value = #{value}" }