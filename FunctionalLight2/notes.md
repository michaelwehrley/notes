* `constant(v)` is a machine making machine => a function that returns a function:
```
constant(v) {
  return function() {
    return v;
  }
}
```
