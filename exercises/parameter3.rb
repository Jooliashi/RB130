
items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*first, second|
  puts first.join(', ')
  puts second
end

gather(items) do |first, *second, last|
  puts first
  puts second.join(', ')
  puts last
end

gather(items) do |first, *second|
  puts first
  puts second.join(', ')
end

gather(items) do |first, second, third, last |
  puts "#{first}, #{second}, #{third}, #{last}"
end