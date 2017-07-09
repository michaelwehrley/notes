# Memoization

For background info about [fibonacci series function](./recursion.md).

```JavaScript
function fibonacci(n) {
  var memo = [];
  // var memo = {}

  function f(n) {
    var value;

    if (memo[n]) {
    // if (n in memo) {
      value = memo[n];
    } else {
      if (n === 0 || n === 1) {
        value = n;
      } else {
        value = f(n - 1) + f(n - 2);
      }
      memo[n] = value;
    }

    return value;
  }

  return f(n);
}

fibonacci(8); // 21
```

```Ruby
class Compute
  def self.calculation
    n = 100
    @calculation ||= self.factorial(n) # memoization
  end

  def self.factorial(n)
    ((1..n).inject(:*))
  end
end

Compute.calculation # 8709782...
Compute.calculation # 8709782...
```
