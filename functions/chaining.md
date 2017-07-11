# Chaining - The Train Wreck Pattern

* Pattern to return `self` or `this` when otherwise no meaningful return;
* Reads like a sentence;
* Common practice with jQuery & DOM API (document.getElementById('foo').appendChild('div')); but
* Robert Martin finds fault in the fact that this pattern can fail silently.

Examples:

```JavaScript
// JavaScript
one().add().two().equals() // 3
```

```Ruby
# Ruby
one.add.two.equals # Ruby
```

## Javascript

```JavaScript
"use strict";

var calculator = (function() {
  function calculate(value) {
    if (this.operation && this.previous && this.current) {
      this.current = this.operation(this.previous, this.current);
      this.operation = null
    }
  }

  function setOperands(value) {
    if (this.current) {
      this.previous = this.current;
    }
    this.current = value
    calculate.call(this);
  }

  var publicApi = {
    FUNCTION_ARRAY: [
      "zero",
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine"
    ],
    add: function() {
      this.operation = function(a, b) {
        return a + b;
      }

      return this;
    },
    divide: function() {
      this.operation = function(a, b) {
        return a / b;
      }

      return this;
    },
    multiply: function() {
      this.operation = function(a, b) {
        return a * b;
      }

      return this;
    },
    subtract: function() {
      this.operation = function(a, b) {
        return a - b;
      }

      return this;
    },
    equals: function() {
      console.log(this.current);
    }
  }

  for (var i = 0; i < publicApi.FUNCTION_ARRAY.length; i++) {
    (function(i) {
      var name = publicApi.FUNCTION_ARRAY[i];
      publicApi[name] = window[name] = function() {
        setOperands.call(publicApi, i);

        return calculator;
      }
    }(i));
  }

  return publicApi;
}());

one().add().two().equals(); // 3
one().subtract().two().equals(); // -1
one().subtract().three().add().two().equals(); // 0
nine().multiply().three().subtract().seven().divide().five().equals(); // 4
```

## Ruby

```Ruby
class Calculator
  NUMBERS = [
    :zero,
    :one,
    :two,
    :three,
    :four,
    :five,
    :six,
    :seven,
    :eight,
    :nine
  ]

  OPERATIONS = {
    add: :+,
    divide: :/,
    multiply: :*,
    subtract: :-
  }

  NUMBERS.each do |key, value|
    define_method key do
      number = NUMBERS.index(key)

      update_total(number)
    end
  end

  OPERATIONS.each do |key, value|
    define_method key do
      @operation = value

      self
    end
  end

  def equals
    puts @current
  end

  private

  def calculate(value)
    @previous.send(@operation, value)
  end

  def update_total(value)
    @previous = @current
    @current = @current ? calculate(value) : value

    self
  end
end

Calculator.new.one.add.two.add.three.equals # 6
Calculator.new.one.add.eight.subtract.three.divide.two.equals # 3
Calculator.new.one.add.three.subtract.zero.add.two.multiply.nine.equals # 54
```
