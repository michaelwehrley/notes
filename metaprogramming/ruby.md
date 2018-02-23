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
