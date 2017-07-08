# Constructor Functions

## Prototypes and Privacy

* One draw back of the constructor function is that _private_ are created every time a constructor is evoked to create a new object.

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

Overcome this issue by refactoring out the private properties and functions using an IFEE
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
