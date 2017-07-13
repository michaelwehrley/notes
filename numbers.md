# Numbers

```JavaScript
0.1 + 0.2 == 0.3; // false WTF?!
0.1 + 0.2; // 0.30000000000000004 WTF?!
```

## Binary

Try to write *0.1* in binary:

| 0 | . | 1/2  | 1/4  | 1/8   | 1/16   | 1/32    | 1/64     | 1/128     | 1/256      | 1/512       |
|---|---|---   |---   |---    |---     |---      |---       |---        |---         | ---         |
| 0 | . | 0.5  | 0.25 | 0.125 | 0.0625 | 0.03125 | 0.015625 | 0.0078125 | 0.00390625 | 0.001953125 |
| 0 | . | 0    | 0    | 0     | 1      | 1       | 0        | 0         | 1          | 1           |
|Total|.| 0    | 0    | 0     | 0.0625 | 0.09375 | 0.09375  | 0.09375   | 0.09765625 | 0.099609375 |

In the end the results is 0.00011001100110011001100110011001100110011001100110011001100110...
This result is equivalent as 0.1 in decimal/base 10.
Furthermore computers can't go for ever - they stop.

You may see this written as (0.1)<sub>10</sub> = (0.000110011001100110011...)<sub>2</sub>

Converting *0.1* in double binary (8 bytes/64 bits):
0.0001100110011001100110011001100110011001100110011001101

## "Types"

Writing your own `isInteger` method:
```JavaScript
function isInteger(x) {
  // NaN^0 => 0
  return (x^0) === x;
}

isInteger(3) // true
isInteger(NaN) // false
isInteger(0.1) // false
```

Writing your own `isInteger` method for `Number`:

```JavaScript
function myIsIntegerFunc() {
  // NaN^0 => 0
  var num;

  num = this.valueOf();
  return (num^0) === num;
}

if (typeof Number.myIsIntegerFunc === "undefined") {
  Number.prototype.myIsIntegerFunc = myIsIntegerFunc;
}

// Similarily you could...
// Number.myIsIntegerFunc = Number.myIsIntegerFunc || myIsIntegerFunc;

var num = 3;
num.myIsIntegerFunc(); // true
```

## Floating Point Precision
_notes...rough draft_

Converting a binary number to IEE 754 we desire our number in normalized binary scientific notation:
1.100110011001100110011001100110011001100110011001101 * 2^-4

*JavaScript*
* According to ECMAScript standard, all numbers/arithmetic are completed using 64-bit Floating Point arithmetic.
* That is a number takes up 8 bytes (64 bits) in computer memory.

`(−1)s × c × bq`
* `s` = a sign (zero or one) - one indicates a negative number
* `c` = a significand (or 'coefficient')
* `q` = an exponent

| Value | Exponent | Sign |
| --- | --- | --- |
| 52 bits (0 - 51) | 11 bits (52 - 62) | 1 bit (63) |
| 1.1001100110011001100110011001100110011001100110011010 | 01111111011 | 0 |

With that, always know that 1 will be the leading number, so we can ignore that.
Significand: `1001100110011001100110011001100110011001100110011010`
Exponent is -4: `01111111011`
Sign is positive so it is `0`

*0.1* in double-precision:
Sign: 0
Exponent: 01111111011
Significand: 1.1001100110011001100110011001100110011001100110011010

* These numbers are also referred to as _double-precision floating-point format_ or _binary64_ - NOT _64-bit decimal format_ i.e., _decimal64_
* Javascript follows the international _IEEE 754 standard/IEEE Standard for Floating-Point Arithmetic_.
* JavaScript does not define different types of numbers, like integers, short, long, floating-point etc.
* Compare to *Ruby* where `Numeric` is a base class for other, more specific, number objects, such as `Fixnum`, `Float`, and `Bignum`.
* Note: _IEEE 754-2008_ published in August 2008, is derived from and replaces _IEEE 754-1985_, the previous version
