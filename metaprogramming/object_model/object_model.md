# Object Model

The "object model" is common in object based languages us as Ruby, Java, JavaScript, Python, and the DOM

## Object vs Class

Object Oriented Design
* State (i.e., @instance_variables) - look up in `self`
* Behavior (i.e., `methods`) - look up in `self`\`s class
 - if you don't specify a specific receiver, ruby will look for that method on `self`

Signs of class
* `<` subclassing/inheritance of an expression that returns a class object.
* Unified Modeling Language (UML) killed object oriented programing with the focus on classes and inheritence
*

We see this all the time:
```ruby
class A
end
```
What A is inheriting from is `Object`
```ruby
class A < Object
end
```
I can also be written as:
```ruby
A = Class.new(Object)
```

```ruby
class B
end
B.ancestors # => [B, Object, Kernel, BasicObject] 

class C < Object
end
C.ancestors # => [C, Object, Kernel, BasicObject] 

D = Class.new(Object)
D.ancestors # => [D, Object, Kernel, BasicObject] 
```

### Ducktyping

Class in ruby is just an object.  Ruby has no idea what a class is.

```ruby
class A < (rand(10) > 5 ? Array : Hash)
  def foo
    "#{self.class.new}: #{self.class.superclass}"
  end
end

A.new.foo # => "{}: Hash"

class B < (rand(10) > 5 ? Array : Hash)
  def foo
    "#{self.class.new}: #{self.class.superclass}"
  end
end

B.new.foo # => "[]: Array" 
```

```ruby
class B < "A"
end
# TypeError: superclass must be a Class (String given)
```

## Ruby Object Model

### Ancestors

...



```ruby
class Foo
  def self.foo
    "foo"
  end

  puts "self.instance_of?(Class) #{self.instance_of?(Class)}"
  # puts "self.instance_methods1: #{self.instance_methods}"

  # class << self
  #   puts "self.instance_methods2: #{self.instance_methods}"
  # end
end
```

# ~/.rvm/rubies/ruby-2.3.2/bin/irb
```ruby
module Bar
  def burp
    "barurp"
  end

  def speak
    "hello bar"
  end
end

module Baz
  def burp
    "bazurp"
  end
end

class Foo
  include Bar
  include Baz # Takes precedence

  def self.speak
    "who speaks?"
  end

  def speak
    "hello foo"
  end
end

foo1.class.ancestors # => [Foo, Baz, Bar, Object, Kernel, BasicObject] 
foo1.class.superclass # => Object 
foo1.class.superclass.superclass # => BasicObject 
foo1.class.superclass.superclass.superclass # => nil 

foo1 = Foo.new
foo1.speak # => "hello foo" 

foo2 = Foo.new
foo2.burp # => "bazurp" 

def foo1.snore
  "snsnsnsns"
end

foo1.snore # => "snsnsnsns"
foo2.snore # => NoMethodError: undefined method `snore' for #<Foo:0x007fb2b6123138>

obj1 = Object.new # => #<Object:0x007fb2b70d4988> 
def obj1.foo
 "singleton foo"
end
obj1.foo
```

## Singleton Methods

```ruby
Foo.singleton_methods # => [:speak] 
obj1.singleton_methods # => [:foo] 
```

## Java Object Model



## Python Object Model

## Document Object Model (i.e., the DOM)

## Page Object Models