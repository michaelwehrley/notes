# Object Model

## Ancestors

```ruby
module Baz
  private

  def please_give_me_privacy
  end
end

class Foo
  include Baz

  def i_am_public
  end
end

class Bar < Foo
  I_AM_ME = "You are you".freeze
end

bar = Bar.new

bar.instance_variable_set("@x", 10) #=> #<Bar:0x007fbc688514f8 @x=10>
bar.instance_variable_get("@x") #=> 10

bar.class #=> Bar
bar.class.class #=> Class
bar.methods #=> [:i_am_public, :instance_of?, :public_send, :instance_variable_get, :instance_variable_set,...]
Bar.constants #=> [:I_AM_ME] 
Bar.superclass #=> Foo
Bar.ancestors #=> [Bar, Foo, Baz, Object, Kernel, BasicObject]
# `Baz` is a module
# `Kernel` is a module
Baz.private_instance_methods #=> [:please_give_me_privacy] 
```

### Class vs Module

* Modules are used for including in other classes or namespacing.
* Classes are used when you intend for it to be instantiated.

### Private Methods

Can only be called with an implicit reciever `self`

### Kernel

Some fun common `Kernel` methods:
* `#method_missing`
* `print`
* `.private_instance_methods`
* `.public_instance_methods`
* `.singleton_methods`

# Methods

## Ghost Methods
Don't introduce more **Ghost Methods** than necessary.

```ruby
class Roulette
  def method_missing(name, *args)
    i = 0
    3.times do
      puts "#{i = rand(10) + 1}..."
    end
    puts "#{name} got a #{i}"
  end
end

number_of = Roulette.new
puts number_of.bob
puts number_of.frank
```

# Blocks

Blocks are **NOT** objects.

## Managing Exceptions With Blocks


[example](./blocks/spec.rb)
```ruby
["example"](File.join(File.dirname(__FILE__), "blocks/spec"))

module Kernel
  def using(resource)
    yield
  ensure
    resource.dispose
  end
end
```

## Flattening Scopes

We use `class`, `module`, and `def` to create basic scopes for variables.

However, we can open the capture the current bindings and pass them the closure.
We do this by replacing:
* `class` with `Class.new()`
* `module` with `Module.new()`
* `def` with `define_method`

```ruby
genus = "Vitis"
species = "Vinifera"

class Wine
  puts "#{genus} #{species}"
end

# NameError: undefined local variable or method `genus' for Wine:Class
# Did you mean?  genus
```

```ruby
genus = "Vitis"
species = "Vinifera"

class Wine
  def terroir
    puts "terroir is not #{genus} #{species}"
  end
end

Wine.new.terroir
# NameError: undefined local variable or method `genus' for #<Wine:0x007f91630574d0>
# from (irb):6:in `terroir'
```

## Flatten Scopes with `Class.new()` and `define_method`

```ruby
genus = "Vitis"
species = "Vinifera"

Wine = Class.new do
  puts "#{genus} #{species}"

  define_method :terroir do
    puts "terroir is not #{genus} #{species}"
  end
end
# Vitis Vinifera

Wine.new.terroir # terroir is not Vitis Vinifera
```

## Instance Variables

```ruby
class Herbaceous
  def initialize
    @flavor = "The dominate flavor of a herbaceous wine is not of a sweet fruit."
  end

  def taste
    return puts @flavor
  end
end

sauvignon_blanc = Herbaceous.new
sauvignon_blanc.taste # The dominate flavor of a herbaceous wine is not of a sweet fruit.
```

### `instance_eval()` - Great for setting up specs

```ruby
class Herbaceous
  def initialize
    @flavor = "The dominate flavor of a herbaceous wine is not of a sweet fruit."
  end

  def taste
    return puts @flavor
  end
end

sauvignon_blanc = Herbaceous.new
sauvignon_blanc.taste # The dominate flavor of a herbaceous wine is not of a sweet fruit.

sauvignon_blanc.instance_eval do
  @flavor = "Herbaceous wines are the antithesis of fruit-forward wines."
end

sauvignon_blanc.taste # Herbaceous wines are the antithesis of fruit-forward wines.
```

## Calling Blocks - Proc Objects & Deferred Evaluation

Because blocks are not objects, in order to store them and execute later, we will need an object!

We use `Proc`.  A `Proc` is a block that is turned into an **object**.

### `Proc.new()`

```ruby
# if this is your goal
something do |x|
  x * 3
end
# your block would be:
multiplier = Proc.new { |x| x * 3 } # => #<Proc:0x007fa39d041990@(irb):1> 
# call later
multiplier.call(2) # => 6
```

### Kernel Alternatives `lambda()` & `proc()`

```ruby
multiplier = lambda { |x| x * 3 } # => #<Proc:0x007fd292936220@(irb):1 (lambda)> 
# call later
multiplier.call(2) # => 6
```

## `&`



