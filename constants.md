# Constants

Typical notation is to upper case constants: `I_AM_A_CONSTANT`

## Ruby

* Freezing in ruby doesn't allow the *value* to be updated.

1. Typical example: `PI = "3.14"`
1. Freezing a constant so it can't be updated: `PI = "3.14".freeze`
1. Include the magic comment `# frozen_string_literal: true`

In Ruby 2.3, the "magic" comment tells Ruby that all string literals in the file are implicitly frozen.

Ruby 3 supports this behavior by default.

```Ruby
# frozen_string_literal: true

PI = "3.14"
PI << "159265359" # RuntimeError: can't modify frozen String
```

## JavaScript

* Freezing in JS doesn't allow the *assignment* to be updated.

Update `var` to be `const`

```JavaScript
var PI = "3.14"
PI = "3.14159265359" // "3.14159265359"
```

```JavaScript
const PI = "3.14"
PI = "3.14159265359" // TypeError: Assignment to constant variable.
```
