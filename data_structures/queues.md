# Queues

* First one in, first one out
* Compare to [stacks](./stacks.md)

```JavaScript
/**
 * Implements a basic queue
 * @param { Number } capacity - The default queue capacity
 */

"use strict";

function Queue(capacity) {
  this.capacity = capacity || Infinity;
}

Queue.prototype = (function() {
  var ERROR_MESSAGE =
      "Max capacity already reached. " +
      "Remove element before adding a new one.";
  var MISSING_MESSAGE = "Sorry, but the value isn't in the queue";
  var first = 1;
  var last = 0;
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
      if (length < this.capacity) {
        last += 1;
        length += 1;
        data[last] = value;
        return this.size(); // JS implementation
      } else {
        return (ERROR_MESSAGE);
      }
    },

    dequeue: function dequeue() {
      var item;

      if (length > 0) {
        item = data[first];

        delete data[first];
        first += 1;
        length -= 1;

        return item;
      }
    },

    // O(1)
    // Element that would be dequeued
    peek: function peek() {
      return data[first];
    },

    // O(1)
    // Size of the queue
    size: function size() {
      return length;
    },

    // O(n)
    // Number of dequeues until you get to a certain value
    until: function until(value) {
      if (this.contains(value)) {
        for (var key in data) {
          if (data[key] === value) {
            return key - first + 1;
          }
        }
      } else {
        return MISSING_MESSAGE; // Sorry, but the value isn't..
      }
    }
  };

  return publicAPI;
}());

var queue = new Queue(4);

queue.enqueue("foo");   // 1
queue.peek();           // "foo"
queue.enqueue("bar");   // 2
queue.peek();           // "bar"
queue.contains("foo");  // true
queue.contains("hello");  // true
queue.enqueue("hello"); // 3
queue.until("hello");   // 3
queue.enqueue("baz");   // Max capacity already reached...
queue.peek();           // "foo"
queue.size();           // 3
queue.dequeue();        // "foo"
queue.enqueue("baz");   // 3
queue.size();           // 3
queue.dequeue();        // "bar"
```

## Double-Ended Queue

![Double-Ended Queue](/assets/double_ended_queue.png)

Implement a double-ended queue, with the following methods:

`enqueueLeft`, `dequeueLeft`, `enqueueRight`, `dequeueRight`.

```JavaScript
"use strict";

function Queue() {
  this._current = 0;
  this._next = 0;
  this._data = {};
}

Queue.prototype.enqueue = function enqueue(value) {
  this._data[this._next] = value;
  this._next += 1;
}

Queue.prototype.dequeue = function dequeue() {
  delete this._data[this._current];
  this._current += 1;
}

function DoubleQueue() {
  this._leftQueue = new Queue();
  this._rightQueue = new Queue();
}

DoubleQueue.prototype.enqueueLeft = function(value) {
  this._leftQueue.enqueue(value);
};

DoubleQueue.prototype.denqueueLeft = function() {
  this._leftQueue.denqueue();
};

DoubleQueue.prototype.enqueueRight = function(value) {
  this._rightQueue.enqueue(value);
};

DoubleQueue.prototype.denqueueRight = function() {
  this._rightQueue.denqueue();
};
```

## Queue Using Two Stacks.

```JavaScript
"use strict";

function Stack() {
  this._data = {};
  this._length = 0;
}

Stack.prototype.push = function(value) {
  this._data[this._length += 1] = value;
};

Stack.prototype.pop = function() {
  var length = this._length;

  if (this._data[length]) {
    var topItem = this._data[length];

    delete this._data[length];
    this._length -= 1;

    return topItem;
  }
};

function TwoStackQueue() {
  this.stack1 = new Stack();
  this.stack2 = new Stack();
}

TwoStackQueue.prototype.enqueue = function enqueue(value) {
  for(var i = 0, length = this.stack2._length; i < length; i++) {
    this.stack1.push(this.stack2.pop());
  }

  return this.stack1.push(value);
}

TwoStackQueue.prototype.dequeue = function dequeue() {
  for(var i = 0, length = this.stack1._length; i < length; i++) {
    this.stack2.push(this.stack1.pop());
  }

  return this.stack2.pop();
}

var queue = new TwoStackQueue();
queue.enqueue(3);
queue.enqueue(5);
queue.enqueue(2);
queue.dequeue(); // 3
queue.enqueue(111);
queue.enqueue(11);
queue.dequeue(); // 5
queue.dequeue(); // 2
queue.dequeue(); // 111
```
