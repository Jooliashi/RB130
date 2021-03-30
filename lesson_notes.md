## Blocks

### Closures

A closure is a chunk of code saved for execution later. It binds its surrounding artifacts(variables, methods, objects) and build an enclosure around everything so that they can be referenced when the closure is later executed.

A method to be passed around and used but doesn't have an explicit name.

Ruby uses `Proc` object, a lambda, or a block.

blocks are a form of Proc

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

extra arguments are ignored

missing arguments are considered nil

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

### Variable Scope

```ruby
def call_me(some_code)
    some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"

call_me(chunk_of_code)
```

`chunk_of_code` will drag `name` variable around and keep track of its re-assignment.

The key of "inner scope can access outer scope"

### Symbol to Proc

This symbol shortcut is used with any collection methods that takes a block without any arguments

`(&:to_s)`

`&` in front of an object converts the object into a block

it first checks if the object is a `Proc`; if not it will call `to_proc` on the object

```ruby
def my_method
    yield(2)
end

a_proc = :to_s.to_proc
my_method(&a_proc)
```

If it calls to_proc on a symbol, it returns a proc that will try to invoke the method of the same name on the given object `object.method` 

if you directly use & on a proc, it will convert the whole method content into a block.

if you use symbol to block, you would have to make sure that the given object has access to that method in its class and not expecting the object to be passed in as an argument.

thus if you have methods with arguments, you should use method(symbol_of_method_name)

## Testing

Test Suite: entire set of tests that accompanies your program

Test: a situation in which tests are run. A test can contain multiple assertions

Assertion: actual verification step to confirm that the data returned by your program is correct 

### Expectation Syntax vs Assertion Syntax

Expectation:

​	test writer supplies one or more classes that represent test suites; within each test suite one or more methods define test cases. finally, each test case method has some code that exercises some aspect of the item under test and runs one or more test steps to verify the results.

```ruby
require 'minitest/autorun'

class TestSquareRoot < Minitest::Test
    def test_with_a_perfect_square
        assert_equal 3, square_root(9)
    end
    
    def test_with_zero
        assert_equal 0, square_root(0)
    end
    
    def test_with_non_perfect_square
        assert_in_delta 1.4142, square_root(2)
    end
    
    def test_with_negative_number
        assert_raises(Math::DomainError) { square_root(-3)}
    end
end
```

Expectation:

```ruby
require 'minitest/autorun'

describe 'square_root test case' do
    it 'works with perfect squares' do
        square_root(9).must_equal 3
    end
    
    it 'returns 0 as the square root of 0' do
        square_root(0).must_equal 0
    end
    
    it 'works with non_perfect squares' do
        square_root(2).must_be_close_to 1.4142
    end
    
    it 'raises an exception for negative numbers' do
        proc { square_root(-3).must_raise Math::DomainError}
        end
    end
```

### Writing Tests

Test-Driven Development

1. create a test that fails
2. write just enough code to implement the change or new feature
3. refactor and improve things, then repeat tests

---Red Green Refactor

test sequence is completely random

### Assert methods

- `assert(list.empty?, 'The list is not empty as expected')`

test if the first argument is truthy, can add additional comment as the last argument

- `assert_equal(expected value, actual value)`

It uses `==` operator to perform comparisons

If expected value is `true` or `false` the test only passes if the actual value is exactly equal to `true` it won't pass if it's just truthy or `nil` for `false`

- `assert_in_delta`

Avoid asserting a floating point number has a specific value

`assert_in_delta 3.1415, Math::PI, 0.0001`

3th argument is delta value; it's default is `0.001`

- `assert_same`

checks whether two object arguments are the same object 

`assert_same(ary, ary.sort!)`

first is expected value, second is actual value

uses `equal?`which should never be overridden so it often uses `basicobject#equal?`

- `assert_nil`

checks whether an object is `nil`

`assert_nil(find_todos_list('Groceries'))`

- `assert_empty`

checks whether object returns `true` when `empty?` is called

test fails if the object does not respond to `empty?` or returns a value other than `true`

- `assert_includes`

checks whether a collection includes a specific object  by `include?`

`assert_includes(list, 'xyz')`

- `assert_match`

used when working with String objects. determine whether a string matches a given pattern. It uses regex 

`assert_match(/not found/, error_message)`

### Setup and Teardown

`setup` method is called prior to each test case in the class and perform any setup required for each test.

```ruby
require 'minitest/autorun'
require 'pg'

class MyApp
    def initialize
        @db = PG.connect 'mydb'
    end
    
    def cleanup
        @db.finish
    end
    
    def count; end
    def create(value); end
end

class DatabaseTest < Minitest::Test
    def setup #run before every test case
        @myapp = MyApp.new
    end
    
    def test_that_query_on_empty_database_returns_nothing
        assert_equal 0, @myapp.count
    end
    
    def test_that_query_on_non_empty_database_returns_right_count
        @myapp.create('Abc')
        @myapp.create('Def')
        @myapp.create('Ghi')
        assert_equal 3, @myapp.count
    end
    
    def teardown #run after all test cases
        @myapp.cleanup
    end
end
```

both teardown and setup are optional

### Testing Error Handling

```ruby
def test_with_negative_number
    assert_raises(Math::DomainError) { square_root(-3) }
end
```

It asserts that argument in the block should raise an exception that's either DomainError or subclass of Domain Error

### Testing Output

- assert_silent

ideal situation for methods is no output should be produced

```ruby
def test_has_no_output
    assert_silent { update_database }
end
```

if `update_database` prints anything then assertion will fail

- assert_output

test what and where it gets printed

```ruby
def test_stdout_and_stderr
    assert_output('', /No records found/) do
        print_all_records
    end
end
```

It tests `print_all_records` won't print anything to `stdout` but output an error message to `stderr`

The arguments can take 

`nil`, does not care what gets written to stream

`string`, means the string needs to match output exactly

`regex`, expect a string that matches regex

- capture_io

same as `assert_output`

```ruby
def test_stdout_and_stderr
    out, err = capture_io do
        print_all_records
    end
    
    assert_equal('', out)
    assert_match(/no records found/, err)
end
```

it lets you handle `stderr` and `stdout` separately

### Testing Classes and Objects

- `assert_instance_of`

asserts an object is an object of a specific class 

`assert_instance_of SomeClass, object`

- `assert_kind_of`

an object is an object of a particular class or one of its subclasses

`assert_kind_of SomeClass, object`

- `assert_respond_to`

responds to a given method

`assert_respond_to object, :empty?`

method name can be shown as a symbol or string which will be converted to a symbol

### Refutations

```ruby
ary = [...]
refute(ary.object_id) == method(ary).object_id, 'method(ary) returns copy of original Array')

refute_same ary, method(ary)
```

### Startup Code

`Xyzzy.new.run if __FILE__ == $PROGRAM_NAME`

### SEAT

1. Set up the necessary objects
2. Execute the code against the object we are testing
3. Assert the results of the execution
4. Tear down and clean up any lingering artifacts

### Code Coverage

determine code quality

## Tools

### Gems

--packages of code that you can download, install, and use in Ruby programs

`Gem` manages gems

`gem env` shows details about path and etc

how to find gem's path: `puts $LOADED_FEATURES.grep(/freewill\.rb/)`

If you have many versions of the same gems, it will try to load the version with latest version number

- provide an absolute path name to `require`
- add an appropriate `-I` option to the Ruby invocation
- modify `$LOAD_PATH` prior to requiring `somegem`
- modify the `RUBYLIB` environment variable

### RVM

-- install, manage, and use multiple versions of Ruby

- to work on multiple applications which may standardized on different ruby versions
- natural changes in different ruby versions

directories are split into rubies vs gems 

standard Ruby executables are found in `rubies` and Gems are found in `gems` subdirectory.

`rvm use Version` changes the PATH variable so you can invoke the correct version of ruby

`rvm install Version` to install a particular version of ruby

`rvm use 2.3.1 --default` to change defalt

`rvm use default` to reverse to default

`rvm list rubies` to check what rubies are you using

```ruby
#in your project directory
rvm --ruby-version use 2.2.2
#in your home directory
rvm --ruby-version default
```

this creates a `.ruby-version` file

the file makes RVM replaces `cd` comment with a shell. so when `cd` is now called, the ruby version in the file is inspected and used whenever you switch to a different directory

`Gemfile` is also used for Bundler but `.ruby-version` takes precedence.

`Gemset` is when you tie specific Gems to each of your projects

### rbenv

directories is split between shims and versions(of rubies)

under `version/lib/ruby/gems` there are different versions of `gems` and under that `version` there are specific Gems

rbenv executes `shim script` first and use it to determine which ruby version to use

### bundler

It's a Gem and it lets you configure which Ruby and which Gems each of your projects need

It uses `Gemfile` to inform it which version it should use. The file is a Ruby programs that uses DSL 

`bundle install` scans `Gemfile` and uses it as an instruction to produce `Gemfile.lock`

`Gemfile.lock` will include `specs` a list of Gems scanned and its dependencies. The `bundler` will decide by scanning `Gemfile` belonged to each `Gem` inherently and determine which version of other `Gems` it will need to include 

`require 'bundler/setup' once file is created

`bundle exec` is used to resolve dependency conflicts when issuing shell commands

`bundle exec rake` helps changes environment of rake 

`binstubs` similar to `bundle exec`

### Rake

it automates common functions required to build, test, package and install programs

it uses a `Rakefile` in your directory

```ruby
desc 'Say hello'
task :hello do
  puts "Hello there. This is the `hello` task."
end
#two method calls desc and task
#task method can be followed by a block of code or a list of dependencies

desc 'Say goodbye'
task :bye do
  puts 'Bye now!'
end

desc 'Do everything'
task :default => [:hello, :bye]

$ bundle exec rake -T #when you use bundler
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello

$ bundle exec rake bye
Bye now!
```



## Questions

how to use include Enumerable modules

symbol to proc vs wrapping a method in Method object

understanding file read

```ruby
sample = File.open('sample.txt', 'r+')
text = Text.new(sample.read)
p sample.read
```

#130 study guide list:
### Blocks ###

```ruby
#130 study guide list:
### Blocks ###
# Closures and scope
# How blocks work, and when we want to use them.
# Blocks and variable scope
# Write methods that use blocks and procs
# Methods with an explicit block parameter
# Arguments and return values with blocks
# When can you pass a block to a method
# &:symbol
###Testing With Minitest###
# Testing terminology
# Minitest vs. RSpec
# SEAT approach
# Assertions
### Core Tools/Packaging Code ###
# Purpose of core tools
# Gemfiles
```

