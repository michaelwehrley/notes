# Arrays

`slice`, `splice`, `push`, `shift`, `unshift`, `reverse`

`reverse` and `splice` are not functional b/c they change the existing array

```JavaScript
var array = ['foo', 34, 2, 12, 3, 'b'];

array.slice(0); // ['foo', 34, 2, 12, 3, 'b']
array.slice(3); // [2, 12, 3, 'b']
array.slice(-1); // ['b']
array // ['foo', 34, 2, 12, 3, 'b']
```

```JavaScript
var array, array2;

array = ['foo', 34, 2, 12, 3, 'b'];
array2 = array.splice(0); // ['foo', 34, 2, 12, 3, 'b']
array2 // ['foo', 34, 2, 12, 3, 'b']
array // []

array = ['foo', 34, 2, 12, 3, 'b'];
array2 = array.splice(3); // [12, 3, 'b']
array2 // [12, 3, 'b']
array = ['foo', 34, 2];

array = ['foo', 34, 2, 12, 3, 'b'];
array2 = array.splice(-1); // ['b']
array2 // ['b']
array // ['foo', 34, 2, 12, 3];
```

## Type...

```JavaScript
Object.prototype.toString.call([1,2]) // "[object Array]"
```
## Strings

Using `split` to build an array from a string and `join` to build a string again.
```JavaScript
function isAnagram(phrase1, phrase2) {
  return phrase1.split('').sort().join('') === phrase2.split('').sort().join('');
}

isAnagram("fbg", "bfg"); // true
isAnagram("fbg", "bfgg"); // false
```

Using `RegExp` and allowing numbers
* _note_ the `g` (globa) matching flag.
* _note_ `\w`	will match any word character (letter, number, underscore)
```JavaScript
function isAnagram(phrase1, phrase2) {
  phrase1 = String(phrase1);
  phrase2 = String(phrase2)
  // match will return array of all characters matched
  return phrase1.match(/\w/g).sort().join('') === phrase2.match(/\w/g).sort().join('');
}

isAnagram("f5bg", "bfg5"); // true
isAnagram("f5bg", "bfg 5"); // true
isAnagram("f$#5bg", "bfg 5"); // true
```

## Slice()
`slice()` is a nice *functional* approach to keep original array intact:
```JavaScript
a = ["m", "i", "k", "e"];
b = a.slice(2);
a // ["m", "i", "k", "e"]
b // ["k", "e"]
```

```JavaScript
function foo() {
  // set 'this' to arguments and return new array at index 0
  var args = [].slice.call(arguments, 0);

  return args;
}

foo("m", "i", "ke") // ["m", "i", "ke"]
```

## Splice()
`splice()` augments the original array.

```JavaScript
a = ["m", "i", "k", "e"];
b = a.splice(2);
b // ["k", "e"]
a // ["k", "e"]
```

## Emptying

Setting the `length` property of an array to 0 will empty the array.
```JavaScript
a = ["m", "i", "k", "e"];
a.length = 0;
a // []
```

Redefining an array doesn't change the pointer of referenced arrays in memory:
```JavaScript
a = ["m", "i", "k", "e"];
b = a;
a = [];
a // []
b // ["m", "i", "k", "e"]
```

Using `splice` to update the place in memory will update all references:
```JavaScript
a = ["m", "i", "k", "e"];
b = a;
a.splice(); // a.splice(0) or a.splice(0, a.length);
a // []
b // []
```

## Sorting

```JavaScript
console.log(isSorted([]))                        // true
console.log(isSorted([-Infinity, -5, 0, 3, 9]))  // true
console.log(isSorted([3, 9, 100, -3, 10]))       // false

function isSorted(array) {
  var newArray = array.slice(0);
  return array.sort(compareNumbers).join(",") === newArray.join(",");

  function compareNumbers(a, b) {
    // -1 will be that a is less than b
    // 1 will be that a is greater than b
    // 0 will say they are equal
    return a - b;
  }
}
```
