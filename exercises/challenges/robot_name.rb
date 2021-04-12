=begin
manages robot factory settings specifically names
name method which initializes a new name when called
if the name already exists then method will not change it
  method reset changes the name
need a class variable to track names so when repeated, it will regenerate again
=end
require 'pry'
class Robot
  LETTERS = ('A'..'Z').to_a
  NUMBERS = (0..9).to_a.map(&:to_s)
  @@total_names = []

  def name
    return @name if @name
    create_name
    @@total_names << @name
    @name
  end

  def reset
    @@total_names.delete(@name)
    @name = nil
  end

  private

  def create_name
    @name = ''
    while name_exists? || name.empty?
      2.times { @name << LETTERS.sample}
      3.times { @name << NUMBERS.sample}
    end
  end

  def name_exists?
    @@total_names.include?(@name)
  end
end

p Robot.new.name



