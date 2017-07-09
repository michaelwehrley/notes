# Recursion

## Fibonacci Series

0,1,1,2,3,5,8,13,...

The two recursive calls repeat the same work.
However, to calculate the 50th number, the recursive function must be called over 40 billion times!

```JavaScript
"use strict";

fibonacci(7); // 13

function fibonacci(n) {
  if (n === 0 || n === 1) {
    return n;
  } else {
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}
```

This example runs 'n' times:
```JavaScript
"use strict";

fibonacci(7); // 13

function fibonacci(n) {
  var count = 1
  var previous = 0;
  var current = 1;

  return (function f(n, previous, current) {
    if (n === 0 || n === 1) {
      return n;
    }

    if (count < n) {
      count++;
      f(n, current, previous + current);
    } else {
      console.log(current)
    }
  }(n, previous, current));
}
````
