# Functions

* [Configuration Object](./configuration_object.md)
* [Constructor Functions](./constructor_functions.md)
* [Fibonacci Series](./fibonacci_series.md)
* [Self-Defining Functions](./self_defining_functions.md)
* [IIFE](./IIFE.md)
* [Memoization](./memoization.md)

## Named Function Expression (NFE)

```JavaScript
  var foo = function bar() {
    return 12;
  };

  typeof bar(); // Uncaught ReferenceError: bar is not defined
```

## Run-Time vs Parse Time (compilation?)

`foo` is still `undefined` at run time function declaration
`bar` is defined at run-time
```JavaScript
  bar(); // "hello world";
  foo(); // TypeError: foo is not a function

  var foo = function() {
    return "hello world!";
  }

  function bar() {
    return "hello world!";
  }
```
