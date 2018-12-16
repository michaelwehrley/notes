// function output(txt) {
// 	console.log(txt);
// }

// Point Free Rough Draft...wheels turing
function baz(y) {
  return y;
}

function foo(fn) {
  return function(x) {
    return fn(x)
  }
}

var bar = foo(baz)
bar(3);

// `output` Final 1
// function puts(fn) {
//   return function(txt) {
//     return fn(txt)
//   }
// }

// `output` Final 2 ;-)
function puts(fn) {
  return fn
}

var fn = console.log.bind(console)
var output = puts(fn);
// OR - and EVEN BETTER
var output = console.log.bind(console)

// `printIf`
// function printIf(predicate) {
//   return function(msg) {
//     if (predicate(msg)) {
//       output(msg);
//     }
//   };
// }

// WE HAVE TO KNOW ABOUT `output`
function helloWorld() {
  return function(predicate) {
    return function(message) {
      if (predicate(message)) {
        return output(message)
      }
    }
  }
}

function helloWorld(fn) {
  return function(predicate) {
    return function(message) {
      if (predicate(message)) {
        return fn(message)
      }
    }
  }
}


var printIf = helloWorld();

function isShortEnough(str) {
	return str.length <= 5;
}

// function isLongEnough(str) {
// 	return !isShortEnough(str);
// }

function not(fn) {
  return function(x) {
    return !fn(x);
  }
}

var isLongEnough = not(isShortEnough);

var msg1 = "Hello";
var msg2 = msg1 + " World";

printIf(isShortEnough)(msg1);		// Hello
printIf(isShortEnough)(msg2);
printIf(isLongEnough)(msg1);
printIf(isLongEnough)(msg2);		// Hello World
