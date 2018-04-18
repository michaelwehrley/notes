class Foo1
  class << self
    def foo
      puts "foo in the singleton of Foo1"
    end
  end
end

Foo1.foo

class Foo2
  def self.foo
    puts "foo in the singleton of Foo2"
  end
end

Foo2.foo

module Bar
  def foo
    puts "foo in the singleton of Foo3"
  end
end

class Foo3
  extend Bar
end

Foo3.foo

class Foo4
  def foo
    class << self
      puts "in singleton of Foo4 instance"
    end
  end
end

foo = Foo4.new
def foo.bar
  puts "in singleton of foo instance"
end

foo.foo
foo.bar