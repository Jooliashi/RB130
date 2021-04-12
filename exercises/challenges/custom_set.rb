require 'pry'
class CustomSet
  
  def initialize(data = [])
    @arr = data
  end

  def empty?
    arr.empty?
  end
  
  def contains?(num)
    arr.include?(num)
  end

  def subset?(other_set)
    arr.all? { |ele| other_set.contains?(ele) }
  end

  def disjoint?(other_set)
    return true if empty? || other_set.empty?
    (other_set.arr - arr).size == other_set.arr.size
  end

  def eql?(other_set)
    other_set.arr.uniq.sort == arr.uniq.sort
  end

  def add(num)
    arr << num if !contains?(num)
    self
  end
  
  def ==(other_set)
    arr == other_set.arr
  end
  
  def intersection(other_set)
    new_arr = []
    arr.each do |ele|
      new_arr << ele if other_set.contains?(ele)
    end
    CustomSet.new(new_arr)
  end

  def difference(other_set)
    CustomSet.new(arr - other_set.arr)
  end

  def union(other_set)
    CustomSet.new((arr + other_set.arr).uniq.sort)
  end

  protected

  attr_reader :arr
end

    