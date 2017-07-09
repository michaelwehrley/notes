# Constructor Functions

## Sequence of Events

When calling `new Foo();`

1. Brand new object is created;
1. The new object gets _linked_ to constructor's _prototype_;
1. Context is set to the `this`; and
1. If no return object is returned explicitly, then `this` is returned implicitly.

## Prototypes and Privacy

* One draw back of the constructor function is that _private_ properties and functions are re-created every time a constructor is invoked to create a new object.

```JavaScript
"use strict";

function Foo(firstName, lastName) {
  var name;

  function getFirstName() {
    return firstName;
  }

  function getLastName() {
    return lastName;
  }

  function initName() {
    name = getFirstName() + " " + getLastName()

    return name;
  }

  this.getName = function() {
    return name || initName();
  };
}

// Not added to every object created by the constructor
Foo.prototype.bar = function() {
  console.log("bar");
}

var foo = new Foo("mike", "wehrley");
foo.getName(); //  "mike wehrley"
foo.getName(); //  "mike wehrley"
foo.bar(); // "bar"

var foo2 = new Foo("mike", "wehrley");
foo2.getName(); //  "mike wehrley"
```

Overcome this issue by refactoring out the private properties and functions using an IFEE and setting the prototype.

*Note:* The `this` may change and certain private methods will not be accessible.

```JavaScript
"use strict";

function Foo(firstName, lastName) {
  this.getFirstName = function() {
    return firstName;
  }

  this.getLastName = function() {
    return lastName;
  }
}

Foo.prototype = (function() {
  // private variable
  var name;

  // this can remain private;
  function initName() {
    name = this.getFirstName() + " " + this.getLastName()

    return name;
  }

  // public methods
  return {
    getName: function() {
      return name || initName.call(this);
    }
  }
}());

// Not added to every object created by the constructor
Foo.prototype.bar = function() {
  console.log("bar");
}

var foo = new Foo("mike", "wehrley");
foo.getName(); //  "mike wehrley"
foo.getName(); //  "mike wehrley"
foo.bar(); // "bar"

// doesn't not build functions in memory - linked via prototype
var foo2 = new Foo("mike", "wehrley");
foo2.getName(); //  "mike wehrley"
```

## Circumvent `new` Problem

```JavaScript
// "use strict";

function Foo(name) {
  this.foo = function() {
    return name;
  }
}

var foo1 = new Foo('mike');
foo1.foo(); // "mike"

var foo2 = Foo('mike');
foo // function that is attached to the global object b/c of `this`
foo2.foo(); // Uncaught TypeError: Cannot read property 'foo' of undefined
```
The solution is to make sure the object has a constructor via `instanceof`:

```JavaScript
function Foo(name) {
  var args = Array.prototype.slice.call(arguments);

  // only run if not using `new`
  if (!(this instanceof Foo)) {
    return new Foo(...args);
  }

  this.foo = function() {
    return name;
  }
}

var foo1 = new Foo('mike');
foo1.foo(); // "mike"

var foo2 = Foo('mike');
foo2.foo(); // "mike"
```
