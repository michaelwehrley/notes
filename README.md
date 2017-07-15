# Notes
Programming notes of interest

* [Arrays](./arrays.md)
* [Big O](./big_o.md)
* [Closure](./closure.md)
* [Coercion](./coercion.md)
* [Currying](./currying.md)
* [EventLoop](./event_loop.md)
* [Functions](./functions/functions.md)
* [Lexical Scope](./objects.md)
* [Module pattern](./)
* [Patterns & the Gang of 4](./gang_of_four/gang_of_four.md)
* [NaN](./nan.md)
* [Numbers](./numbers.md)
* [Objects](./objects.md)
* [Regular Expressions](./regular_expressions/regular_expressions.md)
* [Semicolon Insertion](./semicolon_insertion.md)
* [Servers](./servers/servers.md)
* [SOLID](./solid/solid.md)
* [Sorting](./sorting.md)
* [Tail Recursion](./tail_recursion/example.js)
* [this](./this.md)
* [Threads](./threads.md)
* [Types & Casting](./types_and_casting.md)
* ["use strict";](https://www.toptal.com/javascript/interview-questions)
* [Undefined & Null](./undefined_null.md)

## Left-Hand Assignment
```JavaScript
3 = 4 // Uncaught ReferenceError: Invalid left-hand side in assignment
```

## Right-Hand Assignment
```JavaScript
var a = 4
```

## Event-Driven
`target` vs `currentTarget`
https://stackoverflow.com/questions/5921413/difference-between-e-target-and-e-currenttarget
* e.target is what triggers the event dispatcher to trigger and e.currentTarget is what you assigned your listener to.
* e.currentTarget is always the element the event is actually bound do.
* It's worth noting that event.target can be useful, for example, for using a single listener to trigger different actions

## SSH

Warning: the ECDSA host key for 'somewhere.com' differs from the key for the IP address 'XXX.XXX.XXX.XXX'

`$ man ssh-keygen`
-R hostname
           Removes all keys belonging to hostname from a known_hosts file.  This option is useful to delete hashed hosts (see the -H option above).
