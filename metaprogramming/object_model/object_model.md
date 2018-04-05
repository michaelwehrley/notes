```ruby
class Foo
  def self.foo
    "foo"
  end

  puts "self.instance_of?(Class) #{self.instance_of?(Class)}"
  # puts "self.instance_methods1: #{self.instance_methods}"

  # class << self
  #   puts "self.instance_methods2: #{self.instance_methods}"
  # end
end
```
