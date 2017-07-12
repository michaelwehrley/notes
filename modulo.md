# Modulo

The modulo operation finds the *remainder* after division of one number (i.e., dividend) by another (i.e., divisor).
_dividend_
----------
_divisor_

Ruby's `reminder` method (and positive `modulo` method) and JavaScript's function `modulus` behave in the same manor.

*Note*: When either a or n is negative, the naive definition breaks down and programming languages differ in how these values are defined.

## JavaScript
```JavaScript
// Same sign as Dividend
15 % 4 // 3
15 % -4 // 3
-15 % 4 // -3
-15 % -4 // -3
```

```JavaScript
"use strict";

function isPrime(number) {
  var FIRST_PRIME = 2;

  if (!myIsInteger(number) || number < FIRST_PRIME) {
    return false;
  }

  // Optimizations
  // We could augment so `i += 2`
  // We could check up to the square root of the number b/c
  // if a and b were greater than the square root of n,
  // then a * b would be greater than n.
  for (var i = FIRST_PRIME; i < number; i++) {
    if (number % i === 0) { // modulo
      return false;
    }
  }

  return true;

  // Great little function to check to see if a number is an integer
  function myIsInteger(number) {
    return (number^0) === number;
  }
}

console.log(isPrime(2)); // true
console.log(isPrime(3)); // true
console.log(isPrime(4)); // false
console.log(isPrime(5)); // true
console.log(isPrime(8.0)); // false
console.log(isPrime(55)); // false
```

## Ruby
```Ruby
# Same sign as Divisor
15 % 4 # 3
15.modulo(-4) # -1
-15 % 4 # 1 (same sign as divisor)
-15.modulo(-4) # -1 (same sign as divisor)

# Same sign as Dividend
15.remainder(4) # 3
15.remainder(-4) # 3
-15.remainder(4) # -3
-15.remainder(-4) # -3
```
