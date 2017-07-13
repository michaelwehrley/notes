# this

The context of where the function was invoked.

## apply vs call vs bind

You can explicitly set this, by using `apply`, `call`, and `bind`.

`call`: pass in one argument at time

```JavaScript
"use strict";

var test = {
  sayHi: function() {
    console.log("hi");
  }
}

function foo(bar) {
  this.sayHi();
  console.log(bar);
}

foo.call(test, "bye");
```

`apply`: you can pass in an array of arguments for parameters

```JavaScript
"use strict";

var test = {
  sayHi: function() {
    console.log("hi");
  }
}

function foo(arrayOfArguments) {
  this.sayHi();

  for(var i = 0; i < arrayOfArguments.length; i++) {
    console.log(arrayOfArguments[i]);    
  }
}

foo.call(test, ["good", "bye"])
```
