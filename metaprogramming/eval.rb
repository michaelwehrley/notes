Foo = Class.new do
  def bar
    puts "bar"
  end
end

def Foo.foo
  puts "foo"
end

Foo.foo
Foo.new.bar

Foo.class_eval do
  def baz
    puts "baz"
  end
end

Foo.new.baz

Foo.class_eval("puts(self);def babe;puts(self);end")

Foo.new.babe

Foo.instance_eval do # instance - singleton?
  def big
    puts "big"
  end
end

Foo.big