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
```

```ruby
class Animal
  include ActAsDog
end

Animal.bark # NoMethodError: undefined method `bark' for Animal:Class
```
`class` methods are not stored on the class/module, but on the class/module's `eigenclass` - see above.
