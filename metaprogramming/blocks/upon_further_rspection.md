# Upon Further RSpection - Blocks, Procs, and RSpec

## Pre-Workout

## Vocabulary

* Clean Room Pattern
* Deferred Evaluation
* `Proc` & `yield`
* Domain Specific Language (DSL)
* General Purpose Language (GPL)
  * External GPL
  * Internal GPL

## `{ |b| lock }` and :stop_sign: `yield`

### `self yield`
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

[`yield self if block_given?`](https://github.com/rails/rails/blob/master/activerecord/lib/active_record/core.rb#L316)

## The `Proc` Object

## `&` Operator

## `to_proc`

* `Proc#to_proc`
* `Symbol#to_proc`

## :mag: Inspecting `RSpec`
