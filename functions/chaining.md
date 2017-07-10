# Chaining

```JavaScript
// JavaScript
one().plus().two().equals() // 3
```

```Ruby
# Ruby
one.plus.two.equals # Ruby
```

## Javascript

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

      update_current(number)
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

  def update_current(value)
    @previous = @current
    @current = @current ? calculate(value) : value

    self
  end
end

Calculator.new.one.plus.two.plus.three.equals # 6
Calculator.new.one.plus.eight.minus.three.divided_by.two.equals # 3
Calculator.new.one.plus.three.minus.zero.plus.two.multiply.nine.equals # 54
```
