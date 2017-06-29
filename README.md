# Notes
Programming notes of interest

* [Regular Expressions](./regular_expressions/regular_expressions.md)
* [Undefined & Null](./undefined_null.md)
* [Arrays](./arrays.md)
* [Objects](./objects.md)
* [Functions](./functions.md)
* [Closure](./closure.md)
* [Tail Recursion](./tail_recursion/example.js)
* [Servers](./servers/servers.md)
* Module pattern
* this
* ["use strict";](https://www.toptal.com/javascript/interview-questions)
* [semicolon insertion](semicolon_insertion.md)
* [NaN](nan.md)

## Event-Driven

JS
`target` vs `currentTarget`
https://stackoverflow.com/questions/5921413/difference-between-e-target-and-e-currenttarget
* e.target is what triggers the event dispatcher to trigger and e.currentTarget is what you assigned your listener to.
* e.currentTarget is always the element the event is actually bound do.
* It's worth noting that event.target can be useful, for example, for using a single listener to trigger different actions
