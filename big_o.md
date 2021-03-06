# Big O

![Big O](/assets/big_o.png)

## Constant O(k)

Algorithmic time doesn't change as the data increases.
```JavaScript
"use strict";

function getFirst(array) {
  return array[0]
}

getFirst(["c", 2, {}, [], 5]); // "c"
```

## Linear O(n)

```JavaScript
"use strict"

function double(array) {
  return array.map(function(value) { return 2 * value });
}

double([1,2,3]); // [2,4,6]
```

## O(n^2)

### Tuples or Combinations

```JavaScript
"use strict"

// one approach
function tuples(array) { // combinations
  var newArray = [];

  for(var i = 0; i < (array.length - 1); i++) {
    for(var j = i + 1; j < array.length; j++) {
      newArray.push([array[i], array[j]]);
    }
  }

  return newArray;
}

tuples([1,2,3]); // [[1, 2], [1, 3], [2, 3]]
```

### Permutation
```JavaScript
"use strict";

function permute(array) {
  // var newArray = [];
  //
  //
  // for(var i = 0, length = array.length; i < length; i++) {
  //   for(var j = length - 1; j >= 0; j--) {
  //     if (array[i] !== array[j]) {
  //       newArray.push([array[i] + array[j]]);        
  //     }
  //   }
  // }
  //
  // return console.log(newArray);
}

permute('');    // []
permute('ab');  // ['ab', 'ba']
permute('abc'); // ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']
```

### Bubble Sort

```JavaScript
// use a "do" loop - you don't get to use one often

"use strict";

function bubbleSort(array) {
  var current, next, swapped, temp, nextPosition;

  do {
    swapped = false;

    // for(var i = 0; i < array.length - 1; i++) {
    for(var i = 0, length = array.length - 1; i < length; i++) {
      current = array[i];
      nextPosition = i + 1;
      next = array[nextPosition];

      if (current > next) {
        temp = next;
        array[nextPosition] = current;
        array[i] = temp;

        swapped = true;
      }
    }
  } while(swapped);

  return array;
}

bubbleSort([2, 4, 7, 1, 9, 0]); // [0, 1, 2, 4, 7, 9]
```

## O(log n)

Divide and Conquer - find someones phone number in a phone book.

* _Merge Sort_
* Quick Sort
* Trees

_Recursion_ vs _Iterative_

```JavaScript
// recursion example
function recursion(max, current) {
  if (current > max) { return; } // Base Case

  console.log(current);
  recursion(max, current + 1);
}
```

## O(2^n)
Classic fibonacci sequence O(2^n)
* [Fibonacci sequence using memoization](/functions/memoization.md)

```JavaScript
"use strict";

function fibonacci(n) {
  if (n <= 2) { return 1 } // Base Case

  // What is the fib - it is getting the current
  // term by adding the two previous terms
  return fibonacci(n - 1) + fibonacci(n - 2);
}
```

Classic factorial example.
```JavaScript
"use strict";
// How I thought about it...
// (n) * (n - 1) * (n - 2) ...
// 5! = 5 * 4!
// 4! = 4 * 3!

function factorial(n) {
  if (n === 1) {  // Base Case
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}

factorial(1); // 1
factorial(2); // 2
factorial(5); // 120
```

Iterative doesn't have the same stack overflow issues as recursion,
but recursion can be more readable.
