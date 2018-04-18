# Upon Further RSpection - Blocks, Procs, and RSpec (Part I)

## :tropical_drink: Pre-Workout

1. Ruby is full of objects. Is a `block` an object? [Answer](./pre_workout_answer_1.md)
2. Give the class `Foo`:
```ruby
var1 = "A"

class Foo
  var1 = "B"

  def foo
    var1 = "C"
  end

  def bar(var1)
    var1
  end

  var2 = var1
end

var3 = var1
var3 = var2
```
2a. Given the class `Foo` above, evaluate: `Foo.new.foo`

2b. Given the class `Foo` above, evaluate: `Foo.new.bar("D")`

2c. What is `var2`?

2d. What is `var3`?

## Ultimate Goals of Part 1 & 2:
Write our own `RSpec` like framework.

```ruby
RSpec.desribe Foo do
  before do
    Foo.destroy_all
  end

  context "when speaking" do
    before do
      Bar.new
    end

    it "says a lot" do
      assert(Foo.new.speak, "hello, world!")
    end
  end
end
```

## Today's Objectives
However, in order to understand how to the ^ goal we need to learn how to "yield" to blocks and procs :laughing:.

1. Write a method using `yield`;
1. Find cases in our own application that implement `yield`;
1. Understanding the `yield self` pattern and see how Rails harnesses this pattern;
1. Write a method using a `proc` and compare that to `yield`;
1. Write our own methods using `proc`;
1. Write our own `Symbol#to_proc` method; and
1. Use our the idea behind `Symbol#to_proc` to created our own `Class#to_proc` or `Class.to_proc`method.

## Vocabulary
* Blocks: Not really "objects", but they are still "callable."
* Procs: Objects of the class `Proc`.
* Clean Room Pattern
* Deferred Evaluation
* `Proc` & `yield`
* Domain Specific Language (DSL)
* General Purpose Language (GPL)
  * External GPL
  * Internal GPL

## `{ |drop| it.like?(:its_hot) }` and :stop_sign: `yield`

When a method expects a block, it invokes the block by calling the `yield` function.

```ruby
def home_chef
  yield
end

home_chef do "cook with ❤️" end # => "cook with ❤️"
home_chef { "cook with food" } # => "cook with food"
```

### Yielding blocks ~as an argument~
```ruby
def sous_chef
  yield
end

sous_chef("cook with ❤️") # => ArgumentError: wrong number of arguments (given 1, expected 0)
```

### `LocalJumpError`

Raised when Ruby can't `yield` as requested or when using a `return` statement in a loop.
A typical scenario is attempting to yield when no block is given.
```ruby
def sous_chef
  yield
end

sous_chef # => LocalJumpError: no block given (yield)
```

```ruby
3.times do |time|
  return time
end # => LocalJumpError: unexpected return
```

## MealHand

[yield example](https://github.com/homechef/mealhand/blob/74f2f7d375c55c7ddf35d9ebda7da56c3d954de7/spec/features/flash_messages_spec.rb#L6)

## The `self yield` Pattern

### `tap`
```ruby
class Foo
  def initialize
  end

  def home=(fun_name)
    @home = fun_name
  end

  def home
    @home
  end
end

foo = Foo.new.tap { |f| f.home = "chef" }
foo.home # => "chef"
```

### `self(yield)`
```ruby
class Bar
  def self.baz(number)
    yield(number)
  end
end

Bar.baz(3) { |num| num + 1 } # => 4
```

In plain old ruby
```ruby
class Foo
  def initialize
  end

  def home=(fun_name)
    @home = fun_name
  end

  def home
    @home
  end
end

foo = Foo.new do |f|
  f.home = "chef" # `f` is the current instance of Foo
end

foo.home # => nil
```

Implementing `initialize` with `yield`
```ruby
class Foo
  def initialize
    yield(self)
  end

  def home=(fun_name)
    @home = fun_name
  end

  def home
    @home
  end
end

foo = Foo.new do |f|
  f.home = "chef" # `f` is the current instance of Foo
end

foo.home # => "chef"
```

Here is an [example](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/core.rb#L307-L316) of the `yield self` pattern in `ActiveRecord` that we use *every* day. Note: `if block_given?`.

Here is an [example](https://github.com/homechef/mealhand/pull/8395/files#diff-f1a954daa5a68b4ed8e5294d6d870025R6) we have because we get the `yield self` pattern for "free" with Rails (these attributes aren't `attr_accessible`).

## The `Proc` Object & Deferred Evaluation & JS :heart:ers

```ruby
foo = Proc.new { |item| item + item.upcase }
foo.call("my name is bob")
```

### The & (am·per·sand) Operator

*The real meaning of the `&` operator: "This is a `Proc` that I want to use as a block.*

`&` essentially tries to "cast" an object to a block.[+](https://cirw.in/blog/ampex)

You can't do:
```ruby
def my_method(something)
  something
end

my_method { "What am I?" } # => ArgumentError: wrong number of arguments (given 0, expected 1)
```
or this:
```ruby
def my_method
  something
end

my_method { "What am I?" } # => NameError: undefined local variable or method `something' for main:Object
```

`&` is communicating that this is a `Proc` that I want to use as a *block*! It is expecting an instance of a `Proc`. Behind the scenes it is calling `.to_proc` on the block (or a proc instance) before using it as a block (I think).
```ruby
foo = Proc.new { |item| item + item.upcase }
foo == foo.to_proc # true
foo.object_id == foo.to_proc.object_id # true
```

:guitar: Rocking the `Proc`ing!

```ruby
def my_method(&something)
  something
end

my_method { "What am I?" }.to_proc # => #<Proc:0x007faf418a1888@(irb):15> 
```

```ruby
def my_method(&something)
  something
end

my_method { "What am I?" } # => #<Proc:0x007fcb2f055760@(irb):5>
```

```ruby
def my_method(&something)
  something.class
end

my_method { "I am a proc" } # => Proc 
```

```ruby
def my_method(&something)
  something.call
end

my_method { "I was a proc" } # => "I was a proc"
```

Why would we ever use this? Need to pass the block to another method:

Stupid Example
```ruby
def basket_calories(calories, servings, &calc)
  print "There are "
  print calcuation(calories, servings, &calc)
  print " in this basket"
end

def calcuation(a, b)
  "#{yield(a, b)} calories"
end

basket_calories(300, 2) do |calories, servings|
  calories * servings
end # There are 600 calories in this basket => nil 
```

Less Contrived Example
```ruby
%w(Olivia Ave Isabella).map(&:upcase)
# => ["OLIVIA", "AVE", "ISABELLA"]
```

### Hold the :horse: :horse: :horse: :horse: :horse:

```ruby
%w(Olivia Ave Isabella).map("upcase")
# => ArgumentError: wrong number of arguments (given 1, expected 0)
```

```ruby
%w(Olivia Ave Isabella).map(&"upcase")
# => TypeError: wrong argument type String (expected Proc)
```

```ruby
:upcase.to_proc
# => #<Proc:0x007fb0c403cb50(&:upcase)> 
```

Quick Side Note: symbols vs strings
```ruby
"3".object_id == 3.to_s.object_id # false
:foo.object_id == "foo".to_sym.object_id # true
```

## Symbol#to_proc

```ruby
class Symbol
  def to_proc
    Proc.new do |item|
      # `item` is `the name`
      # `self` is `:upcase`
      # `self` is an instance of `Symbol`
      item.send(self.to_sym)
    end
  end
end

%w(Olivia Ave Isabella).map(&:upcase)
# => ["OLIVIA", "AVE", "ISABELLA"]
```

```ruby
class Symbol
  def to_proc
    Proc.new do |item|
      item.send(self.to_sym) + " OMG!!!"
    end
  end
end

%w(Olivia Ave Isabella).map(&:upcase)
# => ["OLIVIA OMG!!!", "AVE OMG!!!", "ISABELLA OMG!!!"] 
```

### Build your own `.to_proc` or `#to_proc` method for `String`

```ruby
class String
  def to_proc
    Proc.new do |item|
      item.__send__(self.to_sym) * 4
    end
  end
end

%w(draft open closed).map(&"upcase")
# => ["DRAFTDRAFTDRAFTDRAFT", "OPENOPENOPENOPEN", "CLOSEDCLOSEDCLOSEDCLOSED"] 
```

Using `proc`s and blocks to build our own `RSpec` DSL in :mag: Upon Further RSpection - Blocks, `Proc`s, and `RSpec` (Part II)

# Upon Further RSpection - Blocks, Procs, and RSpec (Part II)
