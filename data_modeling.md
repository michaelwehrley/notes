# Data-Modeling

## Object Oriented Programming (modeling)

The _WHATS_ (object modeling):
* What is it? (i.e., a building)
* What does it have? (i.e., floors)
* What does it do? ()

Example: [Constructor Function](/functions/constructon_function.md)

```JavaScript
"use strict";

function House(floors, streetAddress) {
  // this = {} - built by default when using `new`
  this.floors = floors;
  this.streetAddress = streetAddress;
  this.zipCode = 10032;
  // implicit return {};
}

// Use prototypal linking so the constructor
// doesn't need to use memory to store the
// function `mailingAddress` for each new House object.
House.prototype.mailingAddress = function() {
  return console.log("We are located at " + this.streetAddress + " " + this.zipCode);
}

new House(3, "67th St") // {floors: 3, streetAddress: "67th St", zipCode: 10032}
(new House(3, "67th St")).mailingAddress() // We are located at 67th St 10032
```

```Ruby
class House
  def initialize(floors, streetAddress)
    @floors = floors
    @streetAddress = streetAddress
    @zipCode = 10032
  end

  def mailing_address
    "We are located at #{@streetAddress} #{@zipCode}"
  end
end

House.new(3, "67th St")
#<House:0x007fd18f879778 @floors=3, @streetAddress="67th St", @zipCode=10032>
House.new(3, "67th St").mailing_address # "We are located at 67th St 10032"
```

## Functional Programming
* Verb based
