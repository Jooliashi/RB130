## Blocks

### Closures

A closure is a chunk of code saved for execution later. It binds its surrounding artifacts(variables, methods, objects) and build an enclosure around everything so that they can be referenced when the closure is later executed.

A method to be passed around and used but doesn't have an explicit name.

Ruby uses `Proc` object, a lambda, or a block.

*the closure retains references to its surrounding artifacts when passed around*

### Usage of blocks

1. defer some implementation code to method invocation decision. It adds more flexibility to a method and keep it more DRY
2. methods that need to perform some "before" and "after" actions - sandwich code. For example, if we need to time, log or notify/ resource management

```ruby
# passing in a block to `Integer#times` method

3.times do |num|
    puts num
end
#returns the calling object and content in the block is ignored

# passing in a block to `Array#map` method

[1, 2, 3].map do |num|
    num + 1
end
#returns a new array, with the values manipulated according to the block code

# passing in a block to `Hash#select` method
# return the new hash object

```

### Making a method

every method can take an optional block as an implicit parameter.

```ruby
def echo(str)
    str
end

echo("hello!") {puts "world" }
#block is ignored here, so we need to `yield` for the block to be accessed

def echo_with_yield(str)
    yield
    str
end
#we have to pass in a block in this case

def echo_with_yield(str)
    yield if block_given? #a method in Kernel
    str
end
```

This allows injecting additional code in the middle of a method later without changing method implementation

```ruby
#method implementation
def say(words)
    yield if block_given?
    puts "> " + words
end

#method invocation
say("hi there") do
    system 'clear'
end
```

sometimes method invocation can be longer than the method implementation

On line 8, `say`method is invoked with two arguments, a block and a string

on line 2, method local variable `words` is assigned the string "hi there". The block is passed in implicitly.

on line 3, method yields to the block and line 9 is then executed

on line 4, `puts` method is called on return value of method call `+ ` on "> " with object pointed to by variable `words` passed in as an argument.

return value for this method is `nil`

```ruby
#yielding with an argument
#block itself is an argument into a method, but the block can also require an argument

def increment(number)
    if block_given?
        yield(number + 1)
    end
    number + 1
end

increment(5) do |num|
    puts num
end
#here the method returns 6 but it's not used
```

### Arity

number of arguments you can pass to a block which has no enforcement.

### Return value of yielding

```ruby
def compare(str)
    puts "Before: #{str}"
    after = yield(str)
    puts "After: #{after}"
end

compare('hello') { |word| word.upcase}
```

### Explicit block parameter

passing a block to a method explicitly

```ruby
def test(&block)
    puts "What's &block? #{block}"
end
#it converts the block argument to `proc` object
```

This provides additional flexibility. Now we have a variable representing the block and we can pass it to another method

```ruby
def test2(block)
    puts "hello"
    block.call #use call to invoke proc
    puts "good-bye"
end

def test(&block)
    puts "1"
    test2(block) #block is turned to a proc object
    puts "2"
end

test { puts "xyz" }
```

