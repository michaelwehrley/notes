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
function addn(arrayOfFns) {
  return add2(arrayOfFns[0], arrayOfFns[1]);
}

var arrayOfFns = [foo, bar, baz];

addn(arrayOfFns); // 7

function baz() {
  return 7;
}

var arrayOfFns = [foo, bar, baz];

addn(arrayOfFns); // 14

// RECURSION