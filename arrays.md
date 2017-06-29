# Arrays

## Strings

Using `split` to build an array from a string and `join` to build a string again.
```JavaScript
function isAnagram(phrase1, phrase2) {
  return phrase1.split('').sort().join('') === phrase2.split('').sort().join('');
}

isAnagram("fbg", "bfg");
```

Using `RegExp` and allowing numbers
* note the `g` (globa) matching flag.
```JavaScript
function isAnagram(phrase1, phrase2) {
  phrase1 = String(phrase1);
  phrase2 = String(phrase2)
  // match will return array of all characters matched
  return phrase1.match(/\w/g).sort().join('') === phrase2.match(/\w/g).sort().join('');
}

isAnagram("fbg", "bfg");
```

## Slice()
`slice()` is a nice *functional* approach to keep original array in take
```JavaScript
a = ["m", "i", "k", "e"];
b = a.slice(2);
b // ["k", "e"]
a // ["m", "i", "k", "e"]
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

Resetting arrays don't change the pointer of referenced arrays in memory:
```JavaScript
a = ["m", "i", "k", "e"];
b = a;
a = [];
a // []
b // ["m", "i", "k", "e"]
```

Updating the place in memory will update all references:
```JavaScript
a = ["m", "i", "k", "e"];
b = a;
a.splice(); // a.splice(0) or a.splice(0, a.length);
a // []
b // []
```
