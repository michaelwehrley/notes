function foo(arg1, arg2) {
	var sum = arg1 + arg2;
	return function bar() {
		debugger;
		return sum;
	}
}

var x = foo(3,4);
debugger;
console.log(x());	// 7
console.log(x());	// 7
