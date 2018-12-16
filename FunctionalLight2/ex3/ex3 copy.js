function increment(x) { return x + 1; }
function decrement(x) { return x - 1; }
function double(x) { return x * 2; }
function half(x) { return x / 2; }

// Answer 1:
function compose(...args) {
  var length = args.length
  var fn;
  var total = 0;

  return function foo(value) {
    fn = args.pop()

    if (fn) {
      total = fn(value);

      return foo(total);
    } else {
      return total;
    }
  }
}

function pipe(...args) {
  var length = args.length
  var fn;
  var total = 0;

  return function foo(value) {
    fn = args.shift()

    if (fn) {
      total = fn(value);

      return foo(total);
    } else {
      return total;
    }
  }
}

var f = compose(decrement,double,increment,half);
var p = pipe(half,increment,double,decrement);

f(3) === 4;
console.log(f(3) === 4)
// true

f(3) === p(3);
console.log(f(3) === p(3))
// true

// Answer 2:
function utility(arrayFn, args) {
  var length = args.length
  var fn;
  var total = 0;

  return function foo(value) {
    // `call()` accepts an argument list: Product.call(this, name, price);
    // `apply()` accepts a single array of arguments: Math.max.apply(null, [1,2,3,4]);
    fn = arrayFn.call(args)

    if (fn) {
      total = fn(value);

      return foo(total);
    } else {
      return total;
    }
  }
}

function compose(...args) {
  return utility(Array.prototype.pop, args)
}

function pipe(...args) {
  return utility(Array.prototype.shift, args)
}

var f = compose(decrement,double,increment,half);
var p = pipe(half,increment,double,decrement);

f(3) === 4;
console.log(f(3) === 4)
// true

f(3) === p(3);
console.log(f(3) === p(3))
// true
