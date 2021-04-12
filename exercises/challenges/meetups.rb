require 'date'
require 'pry'
class Meetup
  attr_reader :date
  WEEKDAY = { 'sunday' => 0,
              'monday' => 1,
              'tuesday' => 2,
              'wednesday' => 3,
              'thursday' => 4,
              'friday' => 5,
              'saturday' => 6
            }
  PATTERN = { 'first' => 1,
              'second' => 2,
              'third' => 3,
              'fourth' => 4,
              'fifth' => 5
            }

  def initialize(year, month)
    @year = year
    @month = month
  end

  def day(weekday, pattern)
    @target_day = WEEKDAY[weekday.downcase]
    if PATTERN.keys.include?(pattern.downcase)
      numbered_pattern(pattern.downcase)
    elsif pattern.downcase == 'last'
      last_pattern
    else
      teenth_pattern
    end
  end

  private
  
  attr_reader :year, :month, :target_day, :date
  attr_writer :date

  def teenth_pattern
    self.date = Date.new(year, month, 13)
    while date.day < 20
      return date if date.wday == target_day
      self.date += 1
    end
  end

  def last_pattern
    self.date = Date.new(year, month, -1)
    until date.wday == target_day
      self.date -= 1
    end
    date
  end

  def numbered_pattern(pattern)
    self.date = Date.new(year, month)
    count = 0
    while count < PATTERN[pattern]
      count += 1 if date.wday == target_day
      self.date += 1
    end
    self.date -= 1
    different_month? ? nil : date
  end

  def different_month?
    date.mon != month || date.year != year
  end
end

=begin
version 2
class Meetup
  SCHEDULE_START_DAY = {
    'first' => 1,
    'second' => 8,
    'third' => 15,
    'fourth' => 22,
    'fifth' => 29,
    'teenth' => 13,
    'last' => nil
  }.freeze

  def initialize(year, month)
    @year = year
    @month = month
    @days_in_month = Date.civil(@year, @month, -1).day
  end

  def day(weekday, schedule)
    weekday = weekday.downcase
    schedule = schedule.downcase

    first_possible_day = first_day_to_search(schedule)
    last_possible_day = [first_possbile_day + 6, @days_in_month].min

    (first_possible_day..last_possible_day).detect do |day|
      date = Date.civil(@year, @month, day)
      break date if day_of_week_is?(date, weekday)
    end
  end

  private

  def first_day_to_search(schedule)
    SCHEDULE_START_DAY[schedule] || (@days_in_month -6)
  end

  def day_of_week_is?(date, weekday)
    case weekday
    when 'monday'    then date.monday?
    when 'tuesday'   then date.tuesday?
    when 'wednesday' then date.wednesday?
    when 'thursday'  then date.thursday?
    when 'friday'    then date.friday?
    when 'saturday'  then date.saturday?
    when 'sunday'    then date.sunday?
    end
  end
end
=end