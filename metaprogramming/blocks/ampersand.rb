def math(a, b)
  yield(a, b)
end

def teach_math(a, b, &operation)
  puts "Let's do the math:"
  puts math(a, b, &operation)
  puts math(a, b, operation)
end

math(2, 3) {} # => nil 
math(2, 3) { |x, y| x * y } # => 6
math(2, 3) { |x, y| x + y } # => 6

# I want to use this block instead
teach_math(2, 3) { |x, y| x - y } # -1
# teach_math(2, 3)


def my_method(&the_proc)
  the_proc
end

p = my_method { |name| "Hello, #{name}!" }
p.class # => Proc
p.call("Bill") # => "Hello, Bill!" 

# proc to blocks

# Procs - one argument:
ages = [5, 15, 24, 55, 67, 43, 99, 201, 300, 304]
money = [5, 25, 14, 555, 62, 22, 33, 53, 19, 1, 31, 53]

# Without a proc
ages.select { |age| age < 50 } # => [5, 15, 24, 43]
money.select { |age| age < 50 }

# With a proc - store a block for later use! DRY up blocks! Pass it around!
my_proc = Proc.new { |age| age < 50 }
ages.select(&my_proc)
money.select(&my_proc)

# Lambda - multiple arguments:
ages = [[5,1,3], [4,6,15]]
ages = [5, 15, 24, 55, 67, 43, 99, 201, 300, 304]
money = [5, 25, 14, 555, 62, 22, 33, 53, 19, 1, 31, 53]

ages = [[5,1,3], [4,6,15]]
my_lambda = lambda { |a, b, c| ["hi", b + a, b, c] }
ages.select(&my_lambda)
