def my_example(name)
  puts "The day after yesterday is #{name} #{yield}"
end

my_example("tmrw") { "unless today is the Big Bang." }

# The day after yesterday is tmrw unless today is the Big Bang.
