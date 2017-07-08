# Numbers

## Floating Point Precision

```JavaScript
console.log(0.1 + 0.2 == 0.3); // false WTF?!
console.log(0.1 + 0.2); // 0.30000000000000004

// general idea...
// 0.1 in binary is 0.0001100110011001101 +
// 0.2 in binary is 0.00110011001100110011 =
// sum in binary is 0.01001100110011001101
// convert 0.01001100110011001101 to decimal: 0.30000019073486328125
```

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
| 12345 | -3 | -1 |
| 12345 | 0.001 | -1 |

−1^1 × 12345 × 10^−3 =
−1 × 12345 × .001 =
−12.345

## Binary

Try to write *0.1* in binary:

| 0 | . | 1/2  | 1/4  | 1/8   | 1/16   | 1/32    | 1/64     | 1/128     | 1/256      | 1/512       |
|---|---|---   |---   |---    |---     |---      |---       |---        |---         | ---         |
| 0 | . | 0.5  | 0.25 | 0.125 | 0.0625 | 0.03125 | 0.015625 | 0.0078125 | 0.00390625 | 0.001953125 |
| 0 | . | 0    | 0    | 0     | 1      | 1       | 0        | 0         | 1          | 1           |
|Total|.| 0    | 0    | 0     | 0.0625 | 0.09375 | 0.09375  | 0.09375   | 0.09765625 | 0.099609375 |

In the end the results is 0.00011001100110011001100110011001100110011001100110011001100110...
This result is equivalent as 0.1 in decimal/base 10.
However computers can't go for ever - they stop.

*0.1* in double binary (8 bytes/64 bits): `0.0001100110011001100110011001100110011001100110011001101`
*0.1* in single binary (4 bytes/32 bits): `0.000110011001100110011001101`
*0.1* in double-precision:
Sign: 0
Exponent: 01111111011
Significand: 1.1001100110011001100110011001100110011001100110011010

* These numbers are also referred to as _double-precision floating-point format_ or _binary64_ - NOT _64-bit decimal format_ i.e., _decimal64_
* Javascript follows the international _IEEE 754 standard/IEEE Standard for Floating-Point Arithmetic_.
* JavaScript does not define different types of numbers, like integers, short, long, floating-point etc.
* Compare to *Ruby* where `Numeric` is a base class for other, more specific, number objects, such as `Fixnum`, `Float`, and `Bignum`.
* Note: _IEEE 754-2008_ published in August 2008, is derived from and replaces _IEEE 754-1985_, the previous version

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
function isInteger() {
  // NaN^0 => 0
  var num;

  num = this.valueOf();
  return (num^0) === num;
}

Number.prototype.isInteger = Number.prototype.isInteger || isInteger

var num = 3;
num.isInteger() // true
```
