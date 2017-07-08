# Singleton

```JavaScript
var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```

## Option 1: Static Property on the Constructor

The drawback is a *publicly accessible* `instance` property via `Universe.instance`

```JavaScript
function Universe() {
  var name = "foo";

  if (Universe.instance) {
    return Universe.instance;
  }
  // this will not work unless we rewrite the constructor method - see Option 2
  // if (instance) {
  //   return instance;
  // }

  this.getName = function() {
    return name;
  }

  Universe.instance = this;
  // this will not work unless we rewrite the constructor method - see Option 2
  // instance = this;

  // implicit return;
  // return this;
}

var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```

## Option 2: Instance in a Closure

```JavaScript
function Universe() {
  var name = "foo";
  var instance = this;

  this.getName = function() {
    return name;
  }

  // The second time we run this the constructor is OVERRIDDEN!
  // Harness closure!
  // and SELF-DEFINING FUNCTIONS!!
  Universe = function() {
    return instance;
  }
}

var uni1 = new Universe();
var uni2 = new Universe();

uni1 === uni2; // true
```
