# Recursion

## Fibonacci Series

0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

The two recursive calls repeat the same work.
However, to calculate the 50th number, the recursive
function must be called over 40 billion times!

```JavaScript
"use strict";

fibonacci(7); // 13

// next value = previous value and previous's previous value
function fibonacci(n) {
  var INITIAL_NUMBER = 2;

  if (n < INITIAL_NUMBER) {
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
  var INITIAL_NUMBER = 2;
  var TOTAL = 1;
  var next;
  var total = TOTAL;
  var previous = total;

  if (n < INITIAL_NUMBER) { return TOTAL; }

  for(var i = INITIAL_NUMBER; i < n; i++) {
    next = total + previous;
    previous = total;
    total = next;
  }

  return total;
}
```

### Other Examples

Takes two arguments - "array" and "number" - and multiplies each
array value by number and returns an array of the values.
```JavaScript
"use strict";

function recursiveMultiplier(array, number) {
  if (array.length === 1) {
    return array[0] * number;
  }

  return [array.shift(0) * number].concat(recursiveMultiplier(array, number));
}

recursiveMultiplier([2,3,5], 2); // [4,6,10]

// Example using iterative pattern.
function recursiveMultiplier(array, number) {
  var length = array.length, newArray = [];

  for(var i = 0; i < length; i++) {
    newArray.push(array[i] * number);
  }

  return newArray;
}

recursiveMultiplier([2,3,5], 2); // [4,6,10]
```

Takes an array and returns its contents in reverse.
```JavaScript
"use strict";

function recursiveReverse(array) {
  if (array.length === 1) {
    return array[0];
  }

  return [array.pop()].concat(recursiveReverse(array));
}

recursiveReverse([3,4,5,9,10]);

// Example using the iterative pattern.
function recursiveReverse(array) {
  var length = array.length, newArray = [];

  for (var i = 0; i < length; i++) {
    newArray[length - i - 1] = array[i];
  }

  return newArray;
}

recursiveReverse([3,4,5,9,10]); // [10,9,5,4,3]
```

### Other Resources

* [Recursion Problems](https://github.com/kuychaco/algoClass/blob/master/recursion/recursionIntro.js)
* [Popular Recursion Interview Questions](https://github.com/kuychaco/algoClass/tree/master/recursion)
