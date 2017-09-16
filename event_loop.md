# JavaScript & Web EventLoop

Anything using `setTimeout` will get set to the event loop.
Because JS is single threaded; `setTimeout` will run after the `console.log(4)`,
because the stack is now empty.

_Synchronized Programming_

```JavaScript
(function() {
  console.log(1);
  setTimeout(function(){ console.log(2) }, 1000);
  setTimeout(function(){ console.log(3) }, 0);
  console.log(4);
})();
// 1,4,3,3
```

![Event Loop](/assets/concurrency_model_and_event_loop.png)

## Node & EventLoop

_`setTimeout` is a Web API._
This is not in Google's [V8](https://developers.google.com/v8/) JS Engine.
Other web [APIs](https://developer.mozilla.org/en-US/docs/Web/API):
* `window` & `document`
* `XMLHttpRequest`

```JavaScript
var timeoutId = window.setTimeout(function () { // increments
  function ajaxCall() {
    //
  }
}, 200);

window.clearTimeout(timeoutId);
```
