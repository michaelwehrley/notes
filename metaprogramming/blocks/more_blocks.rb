# /usr/bin/env ruby

# 1
ages = [3, 5, 26, 33, 55, 34, 94, 12]

puts ages.select { |age| age > 40 }

# 2 Creating a proc - a "block" OBJECT
old = Proc.new { |age| age > 40 }

# 3 Converting proc back into block

puts ages.select(&old)

# Calling the proc later - deferred evaluation

puts old.call(90) # true
puts old.call(21) # false

# Compare? yield vs block

def your_age(age)
  yield
  puts age
end

def my_age(age, &block_as_proc)
  block_as_proc.call
  puts age
end

your_age(37) { print "Your age is..." }
my_age(36) { print "My age is..." }
