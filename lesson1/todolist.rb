class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(todo)
    raise TypeError, "Can only add Todo Object" unless todo.instance_of? Todo
    todos << todo
  end
  alias_method :add, :<<

  def size
    todos.size
  end

  def first
    todos[0]
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all? { |todo| todo.done?}
  end

  def item_at(idx)
    todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(idx)
    raise IndexError if idx >= todos.size
    todos.delete_at(idx)
  end

  def to_s
    text = "---- #{title} ----\n"
    todos.each do |todo|
      text << todo.to_s + "\n"
    end
    text
  end

  def each
    todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    result = TodoList.new(title)
    each do |todo|
      result << todo if yield(todo)
    end
    result
  end

  def find_by_title(str)
    each do |todo|
      return todo if todo.title == str
    end
    nil
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done?}
  end

  def mark_done(str)
    each do |todo|
      return todo.done! if todo.title == str
    end
  end
  
  def mark_all_done
    each { |todo| todo.done!}
  end

  def mark_all_undone
    each { |todo| todo.undone!}
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list

todo1.done!

p list.mark_done("Clean room")
p list

