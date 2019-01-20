# Understanding Computation

## Review

### `inspect`

Ruby is an *expression-orientated* language: Every valid piece of code returns a value.

`inspect` is what returns this value of an object by default.

```ruby
class Foo
	def to_s
		"foo"
	end

	def inspect
		"bar"
	end
end

foo = Foo.new # => 'bar'
"#{foo}" # => foo
```

### `lambda` The Anonymous Function

Quick review:
```js
const foo = function(x, y) {
	return x * y + 4
}
foo(2,3) // => 10
```
```ruby
foo = -> x, y { x * y + 4 }
foo.call(2, 3) # => 10
foo[2, 3] # => 10
```

### Messages

In ruby we sent messages with arguments to an object:

`foo.message(argument1, argument2)`

We define methods for an object to respond to a message:
```ruby
class Foo; def message(arg1, arg2); "arguments: #{arg1} #{arg2}"; end; end

Foo.new.message("bar", "baz") # => "arguments: bar baz"

class Bar; def message(*args); "arguments: #{args}"; end; end

Bar.new.message("foo", "baz") # => "arguments: [\"foo\", \"baz\"]"
```