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
      if (this.size() > 0) {
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

## Minimum Stack

Implement a stack with a `minimum` method which returns the minimum element currently in the stack.
This method should have _O(1)_ time complexity.
Make sure your implementation handles duplicates.

```JavaScript
"use strict";

function miniStack() {
  var publicAPI;
  var data = {};
  var minimumData = {};
  var length = 0;

  function popFromMinimumStack(minimumData, length) {
    delete minimumData[length];
  }

  function pushOnMinimumStack(minimumData, length, value) {
    var previous = minimumData[length - 1];

    if (previous === undefined || value < previous) { // WOW!!
      minimumData[length] = value;
    } else {
      minimumData[length] = previous;
    }
  }

  publicAPI = {
    minimum: function minimum() {
      return minimumData[length];
    },
    peek: function() {
      return data[length];
    },
    pop: function pop() {
      if (length > 0) {
        var topItem = data[length];
        delete data[length];
        popFromMinimumStack(minimumData, length);
        length -= 1;

        return topItem;
      }
    },
    push: function push(value) {
      data[length += 1] = value;
      pushOnMinimumStack(minimumData, length, value);
    },
    size: function size() {
      return length;
    }
  };

  return publicAPI;
}

var stack = miniStack();

stack.push(4);
stack.minimum(); // 4
stack.push(3);
stack.minimum(); // 3
stack.push(3);
stack.minimum(); // 3
stack.push(8);
stack.minimum(); // 3
stack.push(2);
stack.minimum(); // 2
stack.peek();    // 2
stack.size();    // 5
stack.pop();     // 2
stack.minimum(); // 3
```
