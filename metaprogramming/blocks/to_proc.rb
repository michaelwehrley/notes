# require "pry"

class Symbol
  def to_proc
    Proc.new do |item|
      puts "item = #{item}"
      puts "item.class = #{item.class}"
      puts "self = #{self}"
      puts "self.class = #{self.class}"

      item.__send__ self
    end
  end

  def to_proc
    proc do |item|
      puts "item = #{item}"
      puts "item.class = #{item.class}"
      puts "self = #{self}"
      puts "self.class = #{self.class}"

      item.send self
    end
  end
end

items = ["A","b"]
puts items.map(&:downcase)

# if object (i.e., something) passed to items.map(&something) is not a proc, it `&` will implicitly call `to_proc` in the object
# (expected Proc) (TypeError)

my_proc = proc { |item| item.downcase } # items.map { |item| item.downcase } is not items.map({ |item| item.downcase })

# IT IS EXPECTING A PROC!
# items.map(my_proc) #`map': wrong number of arguments (given 1, expected 0)
items.map(&my_proc)
# items.map(3)

m = method(:puts)
p m # => <Method: Object(Kernel)#puts>

m = method(:puts).to_proc
p m # => <Proc:0x007ff56383da00 (lambda)
m.call("hello, world!") # => hello, world!

def foo(letter)
  puts "foo: #{letter}"
end

m = method(:foo)
items = ['a', 'b', 'c']
items.each(&m)

# foo: a
# foo: b
# foo: c

# looping through and calling `m.call(item)`
