# Modules & Name Spacing

## No Dependencies

```JavaScript
// Thank you Kyle Simpson

"use strict";

var wehrlo = (function(){
  var modules = {};

  function define(name, implementation) {
    modules[name] = implementation();
  }

  function get(name) {
    return modules[name];
  }

  var publicAPI = {
    define: define,
    get: get
  };

  // key signature of the module pattern
  return publicAPI;
}());

wehrlo.define("foo", function() {
  function sayHello() {
    return "Hello";
  }

  return {
    sayHello: sayHello
  }
});

wehrlo.get("foo").sayHello(); // "Hello"
```

## With Dependencies

```JavaScript
"use strict";

var wehrlo = (function(){
  var modules = {}

  // Dependencies have to already be defined
  function define(name, dependenciesArray, implementation) {
    for (var i = 0; i < dependenciesArray.length; i++) {
      dependenciesArray[i] = modules[dependenciesArray[i]];
    }

    // `apply` allows for the dependencies to be set as
    // arguments to the implementation function!
    modules[name] = implementation.apply(implementation, dependenciesArray);
    // ES6 spread operator would work as well
    // modules[name] = implementation(...dependenciesArray);
  }

  function get(name) {
    return modules[name];
  }

  var publicAPI = {
    define: define,
    get: get
  };

  // key signature of the module pattern
  return publicAPI;
}());

// Because "foo", must be loaded in as key to
// the object modules ORDER DOES matter!
wehrlo.define("foo", [], function() {
  function sayHello() {
    return "Hello";
  }

  return {
    sayHello: sayHello
  }
});

wehrlo.define("bar", ["foo"], function(foo) {
  function sayHelloWorld() {
    return foo.sayHello() + " World!"; // references dependency
  }

  return {
    sayHelloWorld: sayHelloWorld
  }
});

wehrlo.get("bar").sayHelloWorld(); // "Hello World!"
```
