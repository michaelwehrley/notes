# Coercion

## Javascript

Sorting without a comparative function sorts based on **Unicode**
```JavaScript
[3, 9, -3, 10].sort(); // [-3, 10, 3, 9]
```

```JavaScript
function isSorted(array) {
  return array.sort(compareNumbers) === array;

  function compareNumbers(a, b) {
    // -1 will be that a is less than b
    // 1 will be that a is greater than b
    // 0 will say they are equal
    return a - b;
  }
}
```


```JavaScript
+"4" // 4
"" + 5 // "5"
"foo" * 3 // NaN
3 * "foo"// NaN

// ES6
"foo".repeat(2); // 'foofoo' only for ES6

String(9); // returns the primitive "9"
new String(3); // returns a string object

String(3) === new String(3); // false
```

```JavaScript
String({ foo: "bar" }); // "[object Object]"
```
