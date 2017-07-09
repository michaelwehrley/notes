# Configuration object

A pattern to simplify changing parameters - i.e., requirements :-)

```JavaScript
function addPerson(firstName, lastName) {
  // ....
}
```

But a week later, we need more attributes: age, DOB, and address.
Instead of adding parameters create a _configuration_object_.

* It will also allow for default values.
* Order no longer matters
* Easy to maintain
* - You will need to remember the names of the object's properties

```JavaScript
// configuration = {
//   age: 20,
//   firstName: "Mike"
//   ...
// }
function addPerson(configuration) {
  var age = configuration.age || 18;
  // ....
}
```
