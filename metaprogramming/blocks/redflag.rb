# RSpec set up - come to this by starting with basic setup
#

# Implement the block via `yield` or `&block` keywords

# `yield` (yield)
# `block.call()` via (&block)

# def event(name) #, &block)
#   puts "ALERT: #{name}" if yield
# end

def event(name, &block)
  # convert blocks to `Proc`s and stores them in a hash
  # has is a top-level instance variable so it is visible

  # name is the "text we right" of the method
  @events[name] = block # still a proc...I haven't called `call()`
end

def setup(&block)
  @setups << block
end

# https://ruby-doc.org/core-1.9.3/Dir.html#method-c-glob
# load File.join(Dir.pwd,"metaprogramming", "blocks", "events.rb")
# Dir.glob("*")
Dir.glob("**/*events.rb").each do |rspec_file|
  @events = {}
  @setups = []
  load rspec_file

  @events.each_pair do |event_name, event_block| # vs. `each`
    clean_room_event = Object.new
    @setups.each do |setup|
      # setup.call
      clean_room_event.instance_eval(&setup)
    end
    # @setups.each(&:call)
    # puts "ALERT: #{event_name}" if event_block.call
    puts "ALERT: #{event_name}" if clean_room_event.instance_eval(&event_block)

  end
end

# Setting up sky
# Setting up mountains
# ALERT: the sky is falling
# Setting up sky
# Setting up mountains
# ALERT: it's getting closer
