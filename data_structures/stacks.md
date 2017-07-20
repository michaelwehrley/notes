# Stacks

* Last item in, first item out (LIFO)
  - `push(value)`
  - `pop()`
  - `size()`
  - compare to [queues](./queues.md)
* Call Stack (a list of Stack Frames)
  - Use a constructor function with inner functions to demonstrate call stack;
  - important for recursion; and
  - JS is single threaded - but there are web workers in the DOM to muddy this idea.

![Event Loop](/assets/concurrency_model_and_event_loop.png)

## String Stack
```JavaScript
"use strict";

// First one in, last one out...
// Compare a queue is first one in, first one out.
function Stack() {}

Stack.prototype = (function() {
  var publicAPI;
  var data = "";
  var delimiter = ",";
  var length = 0;

  function getItem(index) {
    if (index === -1) {
      return data;
    } else {
      return data.substr(0, index);
    }
  }

  function resetStack(index) {
    if (index === -1) {
      data = "";
      length = 0;
    } else {
      data = data.slice(index + 1, data.length);
      length -= 1;
    }
  }

  function size() {
    return length;
  }

  publicAPI = {
    peek: function peek() {
      var topItemIndex = data.indexOf(delimiter);

      return getItem(topItemIndex);
    },
    pop: function pop() {
      var topItemIndex = data.indexOf(delimiter);
      var topItem = getItem(topItemIndex);

      resetStack(topItemIndex);

      return topItem;
    },
    push: function push(value) {
      if (size() > 0) {
        data = value + delimiter + data;
      } else {
        data = value;
      }
      length += 1;
    },
    size: function size() {
      return length;
    }
  };

  return publicAPI;
}());

var stack = new Stack();

stack.push("foo");
stack.push("bar");
stack.peek(); // "bar"
stack.size(); // 2
stack.pop();  // "bar"
stack.size(); // 1
stack.pop();  // "foo"
```

## Object Stack
```JavaScript
"use strict";

// First one in, last one out...
// Compare a queue is first one in, first one out.
function Stack() {}

Stack.prototype = (function() {
  var publicAPI;
  var data = {};
  var length = 0;

  function size() {
    return length;
  }

  publicAPI = {
    peek: function() {
      return data[length];
    },
    pop: function pop() {
      if (length > 0) {
        var topItem = data[length]
        delete data[length];
        length -= 1;

        return topItem;
      }
    },
    push: function push(value) {
      data[length += 1] = value;
    },
    size: function size() {
      return length;
    }
  };

  return publicAPI;
}());

var stack = new Stack();

stack.push("foo");
stack.push("bar");
stack.peek(); // "foo"
stack.size(); // 2
stack.pop();  // "bar"
stack.size(); // 1
stack.pop();  // "foo"
```
