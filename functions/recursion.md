# Recursion

## Fibonacci Series

0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

The two recursive calls repeat the same work.
However, to calculate the 50th number, the recursive function must be called over 40 billion times!

```JavaScript
"use strict";

fibonacci(7); // 13
// next value = previous value and previous's previous value
function fibonacci(n) {
  if (n === 0 || n === 1) {
    return n;
  } else {
    return fibonacci(n - 1) + fibonacci(n - 2);
  }
}
```

Compared Recursion to Looping
```JavaScript
"use strict";

fibonacci(3); // 2
fibonacci(7); // 13
fibonacci(10); // 55

function fibonacci(n) {
  var next;
  var previous = 1;
  var total = 1;

  if (n < 2) { return 1; }

  for(var i = 2; i < n; i++) {
    next = total + previous;
    previous = total;
    total = next;
  }

  return total;
}
````
