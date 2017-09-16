# Scope 

## Javascript 

### Lexical Scope

```JavaScript
(function() {
  var a = b = 3;
}());

a // ReferenceError: d is not defined
typeof a // "undefined"
b // 3 (attached to the window b/c not declared)

(function() {
  "use strict";

  var c = d = 5;
}()); // ReferenceError: d is not defined
```

### Garbage Collection

```JavaScript
function foo() {
  console.log("Hello, World!")
}

foo();

foo.[[scope]] // window
```

Because there is a reference to the window still via a hidden property [[scope]],
the garbage collector cannot clear it.

JS does memory allocation via *reachability*.
