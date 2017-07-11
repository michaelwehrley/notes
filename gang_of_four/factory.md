# Factory Method

Define an _interface_ for creating an object, but let _subclasses_ decide which class to instantiate. Factory Method lets a _class defer instantiation to subclasses_.

*Template Method* _not_ explicitly responsible for manufacturing an object.
*Parameterized Factory Method*
*Abstract Factory*

## JavaScript

* Helpful if the constructor doesn't know the type at compile time.

![#f03c15](https://placehold.it/15/f03c15/000000?text=+) Careful! Mind-blowing

```JavaScript
"use strict";

var boolean = new Object(true);
var object = new Object();
var number = new Object(1);
var string = new Object('1');

boolean.constructor === Boolean; // true
object.constructor === Object; // true
number.constructor === Number; // true
string.constructor === String; // true
```

## Ruby
