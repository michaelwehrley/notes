# Event-Driven

## Javascript

`target` vs `currentTarget`

* `event.target` is what triggers the event dispatcher to trigger and `event.currentTarget` is what you assigned your listener to [†](https://stackoverflow.com/questions/5921413/difference-between-e-target-and-e-currenttarget).
* `event.currentTarget` is always the element the event is actually bound do.
* It's worth noting that `event.target` can be useful, for example, for using a single listener to trigger different actions.
