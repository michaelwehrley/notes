class Foo
  def self.bar
    "bar"
  end

  def bar
    self.class.bar
  end
end

Foo.bar # "bar"
Foo.new.bar # "bar"
