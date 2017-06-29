# Currying

```JavaScript
add(3)(4)(5); // 12

function add(x) {
  return function(y) {
    return function(z) {
      return x + y + z;
    }
  }
}

```
