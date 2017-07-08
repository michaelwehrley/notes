# Modulo
The modulo operation finds the *remainder* after division of one number (i.e., dividend) by another (i.e., divisor).
_dividend_
----------
_divisor_

However, Ruby's `reminder` method (and positive `modulo` method) and JavaScript's `modulus` function behave in the same manor.

*Note*: When either a or n is negative, the naive definition breaks down and programming languages differ in how these values are defined.

## JavaScript
```JavaScript
// Same sign as Dividend
15 % 4 // 3
15 % -4 // 3
-15 % 4 // -3
-15 % -4 // -3
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
