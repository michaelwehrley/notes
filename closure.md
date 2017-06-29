# Closure
* Functions are first class objects.

```JavaScript
function mul(factorA) {
  return function multiply(factorB) {
    if (factorB === undefined) {
      return factorA;
    } else {
      factorA = factorA * factorB;
      return multiply;  
    }
  }
}

mul(2)() // 2
mul(2)(3)() // 6
mul(2)(3)(4)() // 24
```
