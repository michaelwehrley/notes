# Notes
Programming notes of interest

[Regular Expressions](./regular_expressions/regular_expressions.md)

## Servers
Run a simple http server in any directory on mac: `python -m SimpleHTTPServer [port number]`

Example: `python -m SimpleHTTPServer 8005`

## Event-Driven

JS
`target` vs `currentTarget`
https://stackoverflow.com/questions/5921413/difference-between-e-target-and-e-currenttarget
* e.target is what triggers the event dispatcher to trigger and e.currentTarget is what you assigned your listener to.
* e.currentTarget is always the element the event is actually bound do.
* It's worth noting that event.target can be useful, for example, for using a single listener to trigger different actions
