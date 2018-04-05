# Eigenclass

## Class Methods

### Use `.self`
```ruby
class Greeting
  def self.speak
    "Hello World"
  end
end

Greeting.speak # => "Hello World"
```

### Use the class name `.Greeting`
```ruby
class Greeting
  def Greeting.speak # More difficult to refactor
    "Hello World"
  end
end

Greeting.speak # => "Hello World"
Greeting.singleton_methods # => [:speak] 
```

### Use the class's eigenclass `class << self`

Because a class method is just a **Singleton Method** on it's eigenclass
```ruby
class Greeting
  class << self # Notation to open up the class's eigenclass
    def speak # Note, we are defining the method on the eigenclass itself.
      "Hello World"
    end
  end
end

Greeting.speak # => "Hello World"
```

## Module Class Methods

Create a module with class methods that other classes can inherit.

```ruby
module ActAsDog
  def self.bark
    "ruf"
  end
end

class Animal
  include ActAsDog
end

Animal.bark # NoMethodError: undefined method `bark' for Animal:Class
```
`class` methods are not stored on the class/module, but on the class/module's **eigenclass**.

## Class Extension / Obect Extension

Instead, let's create the method as an instance method and add that to the class's **eigenclass** via **Class Extenstion**
```ruby
module ActAsDog
  def bark
    "ruf"
  end
end

class Animal
  class << self
    include ActAsDog
  end
end
```

```ruby
class Foo
  def self.foo
    "self.object_id: #{self.object_id}" # => 70227945944020
    self.name
  end

  def Foo.bar
    "self.object_id: #{self.object_id}" # => 70227945944020
    self.name
  end

  def more
    "self.class.object_id: #{self.object_id}" # => 70227942664520
    self.class.name
  end

  class << self
    def baz
      "self.object_id: #{self.object_id}" # => 70227945944020
      self.name
    end
  end
end

Foo.singleton_methods #=> [:foo, :bar, :baz]
```