# # module Foo
# module Foo
#   puts "before"
#   puts self.singleton_methods

#   puts "more"
#   def self.bar
#     "bar"
#   end
#   puts self.singleton_methods

#   puts "self1 = #{self}"
#   class << self
#     puts "instance_methods2 #{self.instance_methods}"
#     puts "self2 = #{self}"
#     def foo
#       puts "self3 = #{self}"
#       puts "self3 = #{self}"
#       puts "instance_methods1 #{self.instance_methods}"
#       "foo"
#     end
#     puts "instance_methods3 #{self.instance_methods}" # `foo` is now an instance method of the eigenclass
#   end

#   puts self.singleton_methods
# end

# Foo.foo

# module Foo
#   def self.foo
#     "foo"
#   end

#   # extend self
#   puts self.singleton_methods
# end

# Foo.foo

class Foo
  BIG = "big"

  def self.bar
    puts "BIG: #{BIG}"
    puts "self.singleton_methods #{self.singleton_methods}"
  end
end

module Bar
  # BIG = "large"
  # class << Foo
  #   prepend Bar
  # end

  def bar
    puts "in module #{BIG}"
  end

  def foo
    puts "#foo module #{BIG}"
  end

  class << Foo
    prepend Bar
  end
end

Foo.bar