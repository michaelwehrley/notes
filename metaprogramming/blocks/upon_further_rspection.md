# Upon Further RSpection - Blocks, Procs, and RSpec

## :tropical_drink: Pre-Workout

1. Nearly everything in ruby is an object. Is a `block` an object? [Answer](./pre_workout_answer_1.md)
1. hmm...
1. Define a simple method without a block. [Answer](./pre_workout_answer_2.rb)
1. Augment the method ^ to display a block if one was provided (hint: `yield`) [Answer](./pre_workout_answer_3.rb)

## Ultimate Goals:
Write our own `RSpec` like framework.  However, in order to understand how to do that we need to yield to blocks and procs :laugh:.

## Today's Objectives
1. Find cases in our own application that implement `yield`
1. Write a method using yield
1. Understanding the `yield self` pattern and see how rails harness it.
1. Write a method using a `proc`
1. Write our own `Symbol#to_proc` method
1. Use our the idea behind `Symbol#to_proc` to created our own `to_proc` method

## Vocabulary
* Clean Room Pattern
* Deferred Evaluation
* `Proc` & `yield`
* Domain Specific Language (DSL)
* General Purpose Language (GPL)
  * External GPL
  * Internal GPL

## `{ |drop| it.like?(:its_hot) }` and :stop_sign: `yield`

```ruby
def home_chef
  puts yield
end

home_chef { "cook with ❤️" }
```
### LocalJumpError

Raised when Ruby can't `yield` as requested.
A typical scenario is attempting to yield when no block is given.
```
home_chef # => LocalJumpError: no block given (yield)
```
```ruby
3.times do |time|
  return time
end # => LocalJumpError: unexpected return
```

## `self yield`
```ruby
class Foo
  attr_accessor :home

  def initialize
    yield self if block_given?
  end
end

foo = Foo.new do |f|
  # f => the current instance of Foo
  f.home = "chef"
end

foo.home # => "chef"
```

View an [example](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/core.rb#L316) in Rails of `yield self if block_given?`.

## The `Proc` Object

### & Operator

The real meaning of the `&` operator: "This is a `Proc` that I want to use as a block.

`&` essentially tries to "cast" an object to a block. [https://cirw.in/blog/ampex]

```ruby
def my_method(&block)
  puts block
end

my_method { "block" } # => #<Proc:0x007fcb2f055760@(irb):5>
```
Slow: https://mudge.name/2011/01/26/passing-blocks-in-ruby-without-block.html

* convert a block to a proc.

A block is not an object.
`yield` doesn't always work when:
1. Need to pass the block to another method:
```ruby
def bar(punctuation)
  yield
end

def foo(punctuation)
  bar(punctuation) { yield }
end

foo("!") { |punc| puts "hello world#{punc}" }
```

### Symbol#to_proc

```ruby
class String
  def to_proc
    Proc.new do |item|
      item.__send__(self.to_sym)
    end
  end
end

%w(draft open closed).map(&:upcase) # => ["DRAFT", "OPEN", "CLOSED"]
```

```ruby
%w(draft open closed).map(&"upcase") # => TypeError: wrong argument type String (expected Proc)
```

```ruby
class String
  def to_proc
    Proc.new do |item|
      item.__send__(self.to_sym)
    end
  end
end

%w(draft open closed).map(&"upcase") # => TypeError: wrong argument type String (expected Proc)
```

```ruby
class Bar; end

["a", "b"].map(Bar) # ArgumentError: wrong number of arguments (given 1, expected 0)
["a", "b"].map(&Bar) # TypeError: wrong argument type Class (expected Proc)

foo = Proc.new { |item| item + item.upcase }

foo == foo.to_proc # true
foo.object_id == foo.to_proc.object_id # true

"3".object_id == 3.to_s.object_id # false
:foo.object_id == "foo".to_sym.object_id # true

["a", "b"].map(foo) # ArgumentError: wrong number of arguments (given 1, expected 0)
["a", "b"].map { |item| item + item.upcase } # => ["aA", "bB"]
["a", "b"].map(&foo) # => ["aA", "bB"]
```

Ruby calls `to_proc` if an ampersand parameter isn’t a proc! Actually by calling `.to_proc` on a proc you get back the proc...

```
[1, 2, 3].map(&:to_s)
[1, 2, 3].map(&method(:String))
```

## `&` Operator

## `to_proc`

* `Proc#to_proc`
* `Symbol#to_proc`

## :mag: Inspecting `RSpec`
