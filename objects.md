# Objects

```JavaScript
typeof 1; // "number"
typeof "1"; // "string"
typeof {}; // "object"
typeof []; // "object"
typeof function() {}; // "function"
typeof new function() {}; // "function"
typeof new Function("return 'hi'"); // function
typeof null; // "object"
typeof undefined; // "undefined"
typeof true; // "boolean"
typeof Boolean; // "function"
typeof new Boolean(); // "object"
```

## hasOwnProperty

## defineProperty

## Properties

## Stringify

JavaScript will implicitly stringify the parameter value.

```JavaScript
var a = {}, b = { key: 'b' }, c = { key: 'c' };
a[b] = 123; // {[object Object]: 123}
a[c] = 456; // {[object Object]: 456}
String(b) // "[object Object]"

console.log(a[b]) // 456

```

In this case, since b and c are both objects, they will both be converted to "[object Object]"

### delete

`delete` only effects properties on objects, not local variables.
```JavaScript
var output = (function(x){
  delete x;
  return x;
})(8);

output; // 8

var x = { foo : 1};
var output = (function(){
  delete x.foo;
  return x.foo;
})();

output; // undefined

var trees = ["redwood","bay","cedar","oak","maple"];
delete trees[3]; // ["redwood","bay","cedar", undefined, "maple"]
trees.length // 5
```

### for in

_for in_
```JavaScript
var obj1 = {
  "firstName": "mike",
  "lastName": "wehrley",
  "age": 401,
  "food": "brussel sprouts"
}

for (attr in obj1) {
  obj1[attr];  // mike; wehrley; 401; brussel sprouts;
}
```
