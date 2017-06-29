# Undefined & Null
* `undefined` is a property of the global object; `window.undefined => undefined`
* In ES3 the variable `undefined` is mutable, while in ES5 it is immutable.
* `null` is a JavaScript keyword - thus `null` inherently unassignable `(Uncaught ReferenceError: Invalid left-hand side in assignment)`

`undefined` is not defined.
```JavaScript
var a;
a === undefined; // true
typeof b // "undefined"
```

_declaring_ and _defining_:
```JavaScript
var c = 3; // (var c; c = 3)
```

_ReferenceError_
```JavaScript
d // Uncaught ReferenceError: d is not defined
```
## Environment
```JavaScript
// ES 5
undefined = 3 // will fail silently
```

```JavaScript
// ES 3
"use strict;"
undefined = 3 // will assign
```

## Compilation vs Runtime
```JavaScript
var y = 1;

// there is no declaring of the function `f` as statements
// within an `if` block are run at runtime.
if (function f(){}) {
  y += typeof f;
}
console.log(y); // 1undefined.
```

```JavaScript
var foo = function f(){};
var y = 1;

if (foo) {
  y += typeof foo;
}
console.log(y); // 1function
```
