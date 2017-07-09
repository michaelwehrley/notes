# Static Public Members

* These are _methods_ or _properties_ that don't change from one instance to another

## Public Static Methods (Memoization)

In JS let's add public static methods on constructor and "instance"
```JavaScript
"use strict";

function Foo() {
  this.baz = function baz() {
    return "baz"
  }
}

Foo.bar = function bar() {
  return "bar"
};

Foo.bar() // "bar"
Foo.baz // "undefined"
Foo.baz() // Uncaught TypeError: Foo.baz is not a function

var foo = new Foo();
foo.bar // undefined
foo.bar() // Uncaught TypeError: foo.bar is not a function
foo.baz() // "baz"
```

In Ruby we have similar problems.
```Ruby
class Foo
  def self.bar
    "bar"
  end

  def baz
    "baz"
  end
end

Foo.bar # bar
Foo.baz # NoMethodError: undefined method `baz' for Foo:Class

foo = Foo.new
foo.bar # NoMethodError: undefined method `bar' for #<Foo:0x007fb62597ecc0>
foo.baz # "baz"
```

We can circumvent this issue a bit by adding a new method to the prototype
which serves as a façade pointing to the constructor's original method.
```JavaScript
"use strict";

function Foo() {}

Foo.bar = function bar() {
  return "bar"
};

Foo.prototype.bar = Foo.bar;

var foo = new Foo();
foo.bar() // "bar"
```

In Ruby we can overcome this by adding the method to the instance.
```Ruby
class Foo
  def self.bar
    "bar"
  end

  # Methods can be redefined for the current `self` which inside a class is itself.
  def bar
    class << self
      self.bar
    end
    # or simply...
    # self.class.bar
  end
end

foo = Foo.new
foo.bar # "bar"
```

## Private Static Methods (Closure)

* Shared by all objects created with the same constructor function
* Not accessible from the outside
