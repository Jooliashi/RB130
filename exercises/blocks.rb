def compute(arg)
  return yield(arg) if block_given?
  "Does not compute."
end


p compute(5) { |arg| arg*2 } 
p compute('a') { |arg| arg*2 } 
p compute('a') == 'Does not compute.'