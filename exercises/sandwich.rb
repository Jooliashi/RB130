
class TextAnalyzer
  def process
    file = File.open('sample.txt', 'r')
    yield(file)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process do |f|
  n = 0
  puts "#{f.readlines.size} lines"
end

analyzer.process do |f|
  n = 0
  f.each_line do |line|
    n += line.split(' ').size
  end
  puts "#{n} words"
end

analyzer.process do |f|
  puts "#{f.read.split("\n").size} paragraphs"
end

