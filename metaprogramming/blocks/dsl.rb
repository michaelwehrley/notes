require "pry"

@events = {}

# Implement the block via `yield` or `&block` keywords

# `yield` (yield)
# `block.call()` via (&block)

# def event(name) #, &block)
#   puts "ALERT: #{name}" if yield
# end

def event(name, &block)
  # convert blocks to `Proc`s and stores them in a hash
  # has is a top-level instance variable so it is visible
  binding.pry

  @events[name] = block # still a proc...I haven't called `call()`
end

def setup(&block)
  @setups << block
end

event "the sky is falling" do
  @sky_height < 300
end

event "it's getting closer" do
  @sky_height < @mountains_height
end

setup do
  puts "Setting up sky"
  @sky_height = 100
end

setup do
  puts "Setting up mountains"
  @mountains_height = 200
end

# Setting up sky
# Setting up mountains
# ALERT: the sky is falling
# Setting up sky
# Setting up mountains
# ALERT: it's getting closer