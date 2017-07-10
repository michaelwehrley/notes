# Chaining - The Train Wreck Pattern

* Pattern to return `self` or `this` when otherwise no meaningful return;
* Reads like a sentence;
* Common practice with jQuery & DOM API (document.getElementById('foo').appendChild('div')); but
* Robert Martin finds fault in the fact that this pattern can fail silently.

```JavaScript
// JavaScript
one().plus().two().equals() // 3
```

```Ruby
# Ruby
one.plus.two.equals # Ruby
```

## Javascript

```JavaScript
"use strict";

var current;
var previous;
var operation;

function calc() {
  if (operation && previous && current) {
    current = operation(previous, current);
    operation = null
  }
}

var calculator = {
  one: one,
  two: two,
  three: three,
  add: function() {
    operation = function(a, b) {
      return a + b;
    }

    return calculator;
  },
  subtract: function() {
    operation = function(a, b) {
      return a - b;
    }

    return calculator;
  },
  equals: function() {
    console.log(current);
  }
}

function setOperands() {
  if (current) {
    previous = current;
  }
}

function one() {
  setOperands();
  current = 1;
  calc();

  return calculator;
}

function two() {
  setOperands();
  current = 2;
  calc();

  return calculator;
}

function three() {
  setOperands();
  current = 3;
  calc();

  return calculator;
}

one().add().two().equals(); // 3
one().subtract().two().equals(); // -1
one().subtract().three().add().two().equals(); // 0
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
    plus: :+,
    minus: :-,
    multiply: :*,
    divided_by: :/
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

Calculator.new.one.plus.two.plus.three.equals # 6
Calculator.new.one.plus.eight.minus.three.divided_by.two.equals # 3
Calculator.new.one.plus.three.minus.zero.plus.two.multiply.nine.equals # 54
```
