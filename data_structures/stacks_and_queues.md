# Stacks

* Last item in, first item out (LIFO)
  * `push(value)`
  * `pop()`
  * `size()`
* Stack in JavaScript (not the same behavior as in C for instance);
  - Functions in JS are stacked;
  - local variables vs. context variables (stored via closures)
    *  Context variables are stored in the the part of the HEAP called _context_
* The HEAP
  - In V8 `null`, `undefined`, `true`, and `false`
* Call Stack (a list of Stack Frames)
  - Use a constructor function with inner functions to demonstrate call stack
  - important for recursion;
  - single threaded - but there are web workers in the DOM

![Event Loop](/assets/concurrency_model_and_event_loop.png)

## String Stack

```JavaScript

```
