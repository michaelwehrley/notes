# Singleton

A design pattern that restricts "instantiation" of a "class" to only one "instance."

* [JavaScript Options](#javascript-options)
* [Ruby Options](#ruby-options)

```JavaScript
// JavaScript example
var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```

```Ruby
# Ruby example
uni1 = Universe.instance
uni2 = Universe.instance

uni1 == uni2 # true
uni1.object_id == uni2.object_id # true
```

## Necessary Background

* [Closure](/functions/closure.md)
* [Constructor functions](/functions/constructor_functions.md)
* [Memoization](/functions/memoization.md)
* [Public Static Members](/functions/public_static_members.md)
* [Private Static Members](/functions/private_static_members.md)
* [Self-Defining Functions](/functions/private_static_members.md)

## JavaScript Options

### Option 1: Use a Static Property on the Constructor

The drawback is a *publicly accessible* `instance` property via `Universe.instance`

```JavaScript
function Universe() {
  var name = "foo";

  if (Universe.instance) { // public static property (i.e., member)
    return Universe.instance;
  }
  // this will not work unless we redefine the constructor method - see Option 2
  // if (instance) {
  //   return instance;
  // }

  this.getName = function() {
    return name;
  }

  Universe.instance = this;
  // this will not work unless we redefine the constructor method - see Option 2
  // instance = this;

  // implicit return
  // return this;
}

var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```

### Option 2: Private Static Member & Closure

```JavaScript
function Universe() {
  var name = "foo";
  var instance = this; // private static variable/property

  this.getName = function() {
    return name;
  }

  // self-defining functions
  Universe = function() {
    return instance; // access to static variable via closure
  }

  // Implicit return the first time
  // return this;
}

var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```

Having Some Fun:

```JavaScript
"use strict";

function Foo() {
  var count = 1;
  var self = this;

  Foo = function() { // self-defining function
    update.call(Foo);

    return self; // return same instance each time
  }

  update.call(Foo);

  function update() {
    this.product = count * count; // public static property
    console.log([count, this.product])
    count++; // private static variable via closure
  }
}

Foo.NAME = "fun"; // constant (i.e., public static property)

var foo1 = new Foo(); // [1, 1]
var foo2 = new Foo(); // [2, 4]
var foo3 = new Foo(); // [3, 9]
Foo.product // 9

foo1 === foo2; // true
foo2 === foo3; // true
foo1 === foo3; // true
```

## Ruby Options

### Option 1: Instantiate One Instance

```Ruby
class Universe
  def initialize
    # @ denotes an instance variable
    @name = "foo"
  end

  # @@ denotes a class variable
  @@universe = Universe.new

  def self.instance
    @@universe
  end

  def get_name
    @name
  end

  # Prohibits the class from calling `new`
  private_class_method :new
end

uni1 = Universe.instance
uni2 = Universe.instance

uni1 == uni2 # true
uni1.object_id == uni2.object_id # true
```

### Ruby Option 2: Ignore Instantiation - Use a Class

```Ruby
class Universe
  def self.get_name
    "foo"
  end
end

Universe.get_name # "foo"
```

### Ruby Option 3: Prohibit Instantiation - Use a Module

```Ruby
module Universe
  def self.get_name
    "foo"
  end
end

Universe.get_name # "foo"
```

* Ruby [inspiration](https://dalibornasevic.com/posts/9-ruby-singleton-pattern)
