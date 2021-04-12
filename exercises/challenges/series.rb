class Series
  attr_reader :str
  def initialize(str)
    @str = str
  end

  def slices(size)
    raise ArgumentError if str.size < size
    str.chars.each_cons(size).map do |serie|
      serie.map(&:to_i)
    end
  end
end