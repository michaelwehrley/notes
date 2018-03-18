#!/usr/bin/env ruby

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

# Buildling Our Own Testing Framerwork DSL vs GPL...

it "the sky is falling" do
  @sky_height < 300
end

it "it's getting closer" do
  @sky_height < @mountains_height
end

before do
  puts "Setting up sky"
  @sky_height = 100
end

before do
  puts "Setting up mountains"
  @mountains_height = 200
end

# Setting up sky
# Setting up mountains
# ALERT: the sky is falling
# Setting up sky
# Setting up mountains
# ALERT: it's getting closer

# via yield
def it(message)
  puts message
  yield
end

# via block
def it(message, &expectation)
  puts message
  expectation.call
end

# How to wire this all up round 1

@its = {}
@before = []

def it(name, &block)
  # convert blocks to `Proc`s and stores them in a hash :-) #########
  # has is a top-level instance variable so it is visible

  # name is the "text we right" of the method
  @its[name] = block # still a proc...I haven't called `call()`
end

# def setup(when = :each, &block)
def before(&block)
  @before << block
end
