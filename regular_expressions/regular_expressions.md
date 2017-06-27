# Regular Expressions

## JavaScript

Regular expression literals can be used to match or replace a pattern:

```JavaScript
var DATE_FORMAT = /^(0[1-9]|1[0-2])\/(0[1-9]|1[0-9]|2[0-9]|3[0-1])\/(\d{4})$/;
var groupings = "01/11/2014".match(DATE_FORMAT);

groupings[1] // month
groupings[2] // day
groupings[3] // year
```

Building a regular expression needed at runtime requires the `RegExp()` constructor:

```JavaScript
  var phrase = "Big Time!";
  var regEx;

  for(var i = 0; i < phrase.length; i++) {
    regEx = new RegExp(phrase[i], "g");

    phrase.match(regEx).length;
  }
```
An example: [isAnagram](./example.js)

*Note: Calling `RegEx()` as a function and not as a constructor behaves the same way* ([1](../../references.md))

Other options for a regular expression:
```JavaScript
"foobar".replace(re, "!") // replaces the first found regex with second parameter (unless it is a global search)
"foobar".search(re) // returns the index
"foobar".test(re) // returns a boolean
```

Remember calling `replace` with a string option only replaces the first occurrence.
```JavaScript
"foobar".replace("o", "!"); // "f!obar"
```

## Ruby
