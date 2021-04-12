=begin
clock class
class method at(int) and to_s method; convert int to a time
the method at can take two integer representing hour and min
class method add which add mins
0 is intepreted as 24:00
=end

class Clock
  attr_reader :hour, :min

  def initialize(hour, min)
    @hour = hour == 0 ? 24 : hour
    @min = min
  end

  def format(int)
    sprintf("%02d", int)
  end

  def self.at(hour, min = 0)
    clock = Clock.new(hour, min)
  end

  def to_s
    "#{format(hour)}:#{format(min)}"
  end

  def refactor
    add_hour, @min = @min.divmod(60)
    @hour += add_hour
    @hour = @hour % 24
  end

  def +(mins)
    add_hour, add_mins = mins.divmod(60)
    @hour += add_hour
    @min += add_mins
    refactor
    self
  end

  def -(mins)
    min_hour, min_mins = mins.divmod(60)
    if @min < min_mins
      @hour -= 1
      @min += 60
    end
    @hour -= min_hour
    @min -= min_mins
    refactor
    self
  end

  def ==(other_clock)
    other_clock.hour == hour && other_clock.min == min
  end
end