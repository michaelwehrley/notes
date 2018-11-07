# JS Asynchronicity

## Promises

Features of the Web Browswer allow us to run **JS asynchronously** - outside our JS Engine itself.

### Browser Features (i.e., Web Browser APIs):

| ------------- | ------------- |
| local storage | `console`     |
| ------------- | ------------- |
| JS Engine     | DOM           |
| ------------- | ------------- |
| XHR Ability   |               |
| ------------- | ------------- |

Other ways of addressing asynchronicity in JS could be **Node background threads**.

#### setTimeout (i.e., a WEB API Timer)

Its only job is to spin up a timer to invoke a function in the web broswer later.

```js
function printHello() {
  console.log("Hello");
}

setTimeout(printHello, 1000); // Not part of JS...part of browser

console.log("Me First!");

// "Me First!"
// "Hello"
```

#### Callback Queue & The Event Loop

```js
function printHello() {
  console.log("Hello");
}

function blockFor1Sec() {
  // blocks JS for 1 second
}

setTimeout(printHello, 0); // => Added to the Callback Queue (after it is done in the Web Browser Feature)
// You aren't storing the function in the queue, are your are REFERENCING its position in JS memory
// Later it is still being INVOKED on the JS Callstack.

blockFor1Sec();

console.log("Me First!");

// "Me First!"
// blockFor1Sec
// Callstack must be empty
// Determining if the callstack is empty and checking the callback queue is a loop of event checking...THE EVENT LOOP
// "Hello"
```

### Promises

Compared to `setTimeout` that really dodn't return anything, a promise will do **2** things:
1. Set up a Web API facade to do what needs to be done.
2. **Return** a promise object that will have a `value` (the value of the web browser code) and an `onFulfilled` it will..

#### `fetch`
```js
function display(data) {
  console.log(data);
}

const futureData = fetch('https://twitter.com/...');
futureData.then(display);

console.log("Me First!");
```

`fetch` returns an object (i.e., a Promise object) and assigns it to `futureData`:

```js
return {
  value: ...,
  onFulfillment: [] // an array of functions that get triggered when the promise resolves
}
```
You could idealistically write `futureData.value`.

Steps:
1. declare a named function `display` in memory
2. set a const `futureData` to `undefined`
3. Invoke `fetch` which runs **both** a Web API and JS (unlike `setTimeout`)
* Creates a Promise object `{value: ..., onFulfillment: [...], status: ....}`
* XMLHTTPRequest in the Web Browser (`XHR`) - unlike the `Timer` we used for `setTimeout`
4. `futureData` is set to `{value: ...., onFulfillment: [], status: ....}`
5. One fulfilled, we want the response of `fetch` to update the property `value` of `futureData`
6. Trigger all functions in `futureData`
7. However, promises are added to the **Job/Microtask** Queue which the **Event Loop** prioritizes over the **Callback Queue**

#### MicroTask Queue

MicroTask Queue, Callback Queues, and Event Loop Example 1:
```js
function display(data) { console.log(data) }
function printHello() { console.log("Hello") }
function blockFor300ms() { /* some code */ }

setTimeout(printHello, 0);

const futureData = fetch("http://twitter.com/asdf/tweets/1") 
futureData.then(display)
blockFor300ms()
```

MicroTask Queue, Callback Queues, and Event Loop [Example 2](https://jakearchibald.com/2015/tasks-microtasks-queues-and-schedules/):
```js
console.log('script start');

setTimeout(function() {
  console.log('setTimeout');
}, 0);

Promise.resolve().then(function() {
  console.log('promise1');
}).then(function() {
  console.log('promise2');
});

console.log('script end');

// script start
// script end
// promise1
// promise2
// setTimeout
```

## Iterators

http://csbin.io/iterators

We want a flow of data and keep track of the current element. This is in contrast to a typical loop:

```js
array = [4,5,6]
for (var i = 0; i < array.length; i++) {
  console.log(array[i])
}
```

```js
function createNewFunction() {
  function add2(num) {
    return num + 2;
  }
  return add2;
}

const newFunction = createNewFunction() // returns add2
// invoke
const result = newFunction(3) // 5
```

### Streaming

```js
function createFunction(array) {
  let i = 0;

  function inner() {
    element = array[i];
    i++;

    return element;
  }

  return inner;
}

const returnNextElement = createFunction([4, 5, 6]);
returnNextElement() // 4
returnNextElement() // 5
returnNextElement() // 6
```

#### `iterate()`

```js
const array = [1, 2, 3, 4];
console.log(sumFunc(array));

function returnIterator(arr) {
  var i = 0;
  
  function foo() {
    var value = arr[i]
    i++;

    return value;
  }
  
  return foo;
}
```

#### `next()`
```js
function nextIterator(arr) {
  var i = 0;

  function foo() {
    var bar = arr[i];
    i++
 
    return bar
  }
 
  return {
    next: foo
  }
}
```

#### Sets & Next

```js
function setIterator(set) {
  var values = set.values()
  
  function foo() {   
    return values.next().value;
  }
  
  return {
    next: foo
  }
}

const mySet = new Set('hey');
const iterateSet = setIterator(mySet);
console.log(iterateSet.next()); // 'h'
console.log(iterateSet.next()); // 'e'
console.log(iterateSet.next()); // 'y'
```
Note:

```
iteratorWithIndex
  next: ƒ foo()
    [[Scopes]]: Scopes[3]
      0: Closure (indexIterator)
        arr: (4) ["a", "b", "c", "d"]
      i: 2
      1: Script {type: "script", name: "", object: {…}}
      2: Global {type: "global", name: "", object: Window}
```

```js
function indexIterator(arr) {
  var i = 0;
 
  function foo() {   
    var value = arr[i];
    var before_i = i;
    i++;
    
    return [before_i, value];
  }
  
  return {
    next: foo
  }
}

const array5 = ['a', 'b', 'c', 'd'];
const iteratorWithIndex = indexIterator(array5);
console.log(iteratorWithIndex.next()); // [0, 'a']
console.log(iteratorWithIndex.next()); // [1, 'b']
console.log(iteratorWithIndex.next()); // [2, 'c']
```

## To Do...

```js
function createNewFunction(num) {
  var sum = 0;

  function add2(num) {
    return num + 2;
  }

  // return add2;

  function add2OrReturnSum(num) {
    if (num) {
      sum = sum + add2(num)
      return add2OrReturnSum;
    } else {
      return sum;
    }
  }

  return add2OrReturnSum;
}

const newFunction = createNewFunction() // returns add2 and sets `sum` in closure
newFunction(3)(); // 5
newFunction(3)(5)(); // 12
newFunction(3)(5)(2)(); // 16
```


```
