# Static Public Members
These are methods or properties that don't change from one instance to another

## Public Static Methods / Memoization
```Ruby
class Bob
  def self.heavy_computation
    n = 100
    @calculation ||= self.factorial(n)
  end

  def self.factorial(n)
    ((1..n).inject(:*))
  end
end

Bob.heavy_computation # 8709782...
Bob.heavy_computation # 8709782...
```
