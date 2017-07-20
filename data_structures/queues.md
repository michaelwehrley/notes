# Queues

* First one in, first one out
* Compare to [stacks](./stacks.md)

```JavaScript
"use strict";

function Queue(capacity) {
  this.capacity = capacity;
}

Queue.prototype = (function() {
  var ERROR_MESSAGE =
      "Max capacity already reached. " +
      "Remove element before adding a new one.";
  var current = 0;
  var length = 0;
  var data = {};

  var publicAPI = {
    contains: function contains(value) {
      for (var key in data) {
        if (data[key] === value) {
          return true;
        }
      }

      return false;
    },
    enqueue: function enqueue(value) {
      if (length === this.capacity) { return (ERROR_MESSAGE); }
      current++;
      length++;
      data[current] = value;
    },

    dequeue: function dequeue() {
      var item;

      if (length > 0) {
        item = data[length];

        delete data[length];
        length -= 1;

        return item;
      }
    },

    peek: function peek() {
      return data[length];
    },

    size: function size() {
      return length;
    }
  };

  return publicAPI;
}());

var queue = new Queue(2);

queue.enqueue("foo");
queue.enqueue("bar");
queue.contains("foo"); // true
queue.enqueue("baz");  // Max capacity already reached...
queue.peek();          // "bar"
queue.size();          // 2
queue.dequeue();       // "bar"
queue.size();          // 1
queue.dequeue();       // "foo"
```
