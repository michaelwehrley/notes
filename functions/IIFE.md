# Immediately-Invoked Function Expression (IIFE)

It says it all...

*invocations:*
`foo();`

*Immediately-Invoked:*

```JavaScript
var count = 0;

(function foo(value) {
  if (count < 10) {
    count++;
    console.log(value);
    return foo(value);  
  }
}("bar"));
```

*Expressions:*
If it isn't a function declaration - that is the line doesn't start with `function`, then it is an expression.

* Commonly used to build modules.
