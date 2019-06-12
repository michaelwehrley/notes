// 1. Write two functions, each which return a fixed number (different from each other) when called.

function foo() {
  return 3;
}

foo(); // 3

function bar() {
  return 4;
}

bar(); // 3


// 2. Write an `add(..)` function that takes two numbers and adds them and returns the result.
//    Call `add(..)` with the results of your two functions from (1) and print the result to the console.

function add(a, b) {
  return a + b;
}

add(foo(), bar()); // 7

// 3. Write an `add2(..)` that takes two functions instead of two numbers,
//    and it calls those two functions and then sends those values to `add(..)`,
//    just like you did in (2) above.

function add2(fn1, fn2) {
  return add(fn1(), fn2());
}

add2(foo, bar); // 7

// 4. Replace your two functions from (1) with a single function
//    that takes a value and returns a function back,
//    where the returned function will return the value when it's called.

function foo2(value) {
  return function bar2() {
    return value;
  };
}

foo2(3)(); // 3

// 5. Write an `addn(..)` that can take an array of 2 or more functions, and using only `add2(..)`,
//    adds them together. Try it with a loop. Try it without a loop (recursion).
//    Try it with built-in array functional helpers (map/reduce).

// LOOP

// RECURSION

function foo(num) {
  return function() {
    return num;
  }
}

three = foo(3);
four = foo(4);
five = foo(5);

function add(a, b) {
  return a + b;
}

function addFn(fn1, fn2) {
  return add(fn1(), fn2());
}

function addN(car, ...cdr) {
  if (cdr.length == 1) return car() + cdr[0]();

  var fn = cdr.pop()
  sumFn = function() {
    return addFn(car, fn);
  }
  return addN(sumFn, ...cdr);
}

addN(three, four, five);


// 6. Start with an array of odd and even numbers (with some duplicates),
// and trim it down to only have unique values.

// Iteration
function inCollection(value, collection) {
  return collection.includes(value)
}

function exclude(array, fn) {
  var collection = [];

  array.forEach(function(value) {
    if (!fn(value, collection)) {
      collection.push(value);
    }
  });

  return collection;
}

exclude([1,3,4,3,6,1,12], inCollection);

function inCollection(value, collection) {
  return collection.includes(value)
}

newArray = []

[1,3,4,3,6,1,12].filter((value) => inCollection(value, newArray));

const result = words.filter(word => word.length > 6);

[1,3,4,3,6,1,12].filter(function(value, _index, array) {
  inCollection(value, array);
})





