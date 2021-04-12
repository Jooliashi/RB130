=begin
class Element
  constructor takes a list of elements
  method datum
  method tail
  method next, find the element after first?
class SimpleLinkedList
  initialize a new list array
  method push for adding an element, it needs to be in element form
  method peek first element in list?
=end

class Element
  def initialize(*elements)
    @data = elements[0]
    elements.size > 1 ? @next = elements[1] : @next = nil
  end

  def datum
    @data
  end

  def next
    @next
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :head

  def size
    current = head
    count = 0
    while current
      count += 1
      current = current.next
    end
    count   
  end

  def empty?
    head.nil?
  end

  def push(element)
    list = Element.new(element, @head)
    @head = list
  end

  def peek
    head.datum if head
  end
  
  def pop
    value = peek
    @head = head.next
    value
  end

  def self.from_a(arr)
    return SimpleLinkedList.new if arr.nil? || arr.empty?
    list = SimpleLinkedList.new
    arr.reverse.each do |ele|
      list.push(ele)
    end
    list
  end

  def to_a
    return [] if empty?
    arr = []
    current = head
    until current.nil?
      arr << current.datum
      current = current.next
    end
    arr
  end
  
  def reverse
    new_arr = to_a.reverse
    SimpleLinkedList.from_a(new_arr)
  end
end
