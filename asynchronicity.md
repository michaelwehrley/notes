# JS Asynchronicity

## Promises

Features of the Web Browswer allow us to run **JS asynchronously** - outside our JS Engine itself.

### Browser Features (i.e., Web Browser APIs):

|               |            |   
| ------------- | ---------- |
| local storage | `console`  |
| ------------- | ---------- |
| JS Engine     | DOM        |
| ------------- | ---------- |
| XHR Ability   |            |
| ------------- | ---------- |

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

[`onFulfilled`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/then)

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
  onFulfilled: [] // an array of functions that get triggered when the promise resolves
}
```
You could idealistically write `futureData.value`.

Steps:
1. declare a named function `display` in memory
2. set a const `futureData` to `undefined`
3. Invoke `fetch` which runs **both** a Web API and JS (unlike `setTimeout`)
* Creates a Promise object `{value: ..., onFulfilled: [...], status: ....}`
* XMLHTTPRequest in the Web Browser (`XHR`) - unlike the `Timer` we used for `setTimeout`
4. `futureData` is set to `{value: ...., onFulfilled: [], status: ....}`
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

### Streaming & Iterators

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

`next()` are methods that when called return an object such as `{ value: 'something', done: false}`

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
console.log(iterateSet.next()); // => 'h'
console.log(iterateSet.next()); // => 'e'
console.log(iterateSet.next()); // => 'y'
```

Notes about Closure Over Execution Context (COVE) - Closure:

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
console.log(iteratorWithIndex.next()); // => [0, 'a']
console.log(iteratorWithIndex.next()); // => [1, 'b']
console.log(iteratorWithIndex.next()); // => [2, 'c']
```

### Generators & `yield` & ES7

*Note:* A generator is an interator that you can push data into and pull data out of.

Leveraging the idea of streams and flows by using ES6 generator `functions*`

```js
function* foo() {
  yield 4
}

bar = foo() // Generator object with a `next` function { next: f* }
bar.next() // => {value: 4, done: false}
bar.next() // => {value: undefined, done: true}
```
#### Passing in Parameter

`yield` breaks out of the function, but new parameter will be added back in place.
```js
function* foo() {
  var baz = yield 5
  yield baz
}

bar = foo() // Generator object with a `next` function { next: f* }
baz = bar.next() // => {value: 5, done: false}
baz.value // => 5
bar.next(3) // => {value: 3, done: false}
bar.next() // => {value: undefined, done: true}
```

```js
function* foo() {
  var baz = yield 5 // baz is NOT set to yield 5 or 5.
  yield baz
}

bar = foo() // Generator object with a `next` function { next: f* }
baz = bar.next() // => {value: 5, done: false}
baz.value // => 5
bar.next() // => {value: undefined, done: false}
bar.next() // => {value: undefined, done: true}
```

```js
function* foo() {
  const start = 10
  var baz = yield 5 + start // baz is NOT set to (yield 5 + start)
  yield 4 + baz
  yield "hi"
}

bar = foo() // Generator object with a `next` function { next: f* }
bar.next() // => {value: 15, done: false}
baz = bar.next(2) // => {value: 6, done: false}
baz.value // => 6
bar.next() // => {value: "hi", done: false}
bar.next() // => {value: undefined, done: true}
```

```js
function* foo() {
  const start = 10
  var baz = yield 5 + start // baz is NOT set to (yield 5 + start)
  yield 4 + baz
  yield "hi"
}

bar = foo() // Generator object with a `next` function { next: f* }
bar.next() // => {value: 15, done: false}
bar.next() // => {value: NaN, done: false} // b/c 4 + `undefined`
bar.next(11) // => {value: "hi", done: false}
bar.next() // => {value: undefined, done: true}
```

## Async/Await (i.e., Async Generators)

We have the `yield` functionality so we can "pause" until a promise is returned.

```JS
function doWhenDataReceived(value) {
  returnNextElement.next(value) // this technique is used to back into the "yield" with the value from the promise
}

function* createFlow() {
  const data = yield fetch("http://twitter...")
  // The `fetch` facade function does 2 things:
  // 1. creates a promise object in js:
  //    { 
  //      value: ...,
  //      status: "pending",
  //      onFulfilled: []
  //    }
  // 2. leverages the browser to make an HTMP XHR Request to Twitter
  // `data` is still `undefined` b/c `yield` is like a `return` and pauses the execution context AND sets this to `futureData`
  // B/c no additional argument is is added to `returnNextElement(somethingHere)`, `yield` will set data.
  console.log("data", data)
}

const returnNextElement = createFlow()
// returns a "generator" object with a `next` function: { next: -f- }
const futureData = returnNextElement().next()
// Enter `createFlow` execution context, but we PAUSE - we won't exit until the end!
// At this point it is the promise object yielded out by the generator `createFlow`
// *NOTE* `data` is still `undefined` - `futureData` is set to the promise.

futureData.then(doWhenDataReceived)
// pass in `doWhenDataReceived` to `onFulfilled` array
// `doWhenDataReceived` will be added to the MicroTask Queue
```

* `futureData.then(doWhenDataReceived)` was needed to trigger setting `data` with the return `value` of the `fetch`.

`async`/`await` simplies this even further.

```JS
async function foo() {
  console.log("me first")
  const response = await fetch("https://swapi.co/api/people/2/?format=json");
  console.log(response);
}

foo();
console.log("me second");

// me first
// me second
// ...
// Response object
```

## Iterators v. Observers

### Iterators - PULLS Data Out
* Gang of 4 described this *ITERATOR* pattern in the 1980s.
* The Consumer PULLS Data OUT of an *iterable* (i.e., an `Array`)

There is an *iterator (i.e., the producer)* and a *consumer*.
Ex: s`var consumer = [1,2,3].iterator()`

```js
function makeRangeIterator(start = 0, end = Infinity, step = 1) {
    let nextIndex = start;
    let iterationCount = 0;

    const rangeIterator = {
       next: function() {
           let result;
           if (nextIndex <= end) {
               result = { value: nextIndex, done: false }
               nextIndex += step;
               iterationCount++;
               return result;
           }
           return { value: iterationCount, done: true }
       }
    };
    return rangeIterator;
}
consumer = makeRangeIterator()

// The consumer is PULLing data out
consumer.next() // {value: 0, done: false}
consumer.next() // {value: 1, done: false}
consumer.next() // {value: 2, done: false}
consumer.next() // {value: 3, done: false}
consumer.next() // {value: 4, done: false}
consumer.next() // {value: 5, done: false}
consumer.next() // {value: 6, done: false}
consumer.next() // {value: 7, done: false}
```
*Note*: if you call `next(4)` an iterator will ignore it, while a generator will actually consume that data.

The consumer can continue to *PULL* data out of the array/iterator until:
1) End of data
2) There is an error

### Observer/Producers (Events/Callbacks) - PUSHES Data to the Consumer

The producer PUSHes data at the consumer.

The produced decides when to send data: when it decides, it will call your callback!
```js
document.addEventListener("mousemove", function next(e) { console.log(e) });
// MouseEvent {isTrusted: true, screenX: 393, screenY: 277, clientX: 393, clientY: 144, …}
// MouseEvent {isTrusted: true, screenX: 403, screenY: 263, clientX: 403, clientY: 130, …}
// MouseEvent {isTrusted: true, screenX: 410, screenY: 253, clientX: 410, clientY: 120, …}
// ...
```
The observer pattern idea can push data until...well forever! The only thing we pass the observer is a callback function.  This is a flaw in their thinking!

We need a way for the producer to tell the observer, "I HAVE NO MORE DATA!"  `Node` streams have ends!

#### Streams & Interface(s)

Consequntly, b/c there is no standard around to let an observer know when the producer is finished sending data we have a multiple ways of implementing this functionality:

* DOM Events
* Websockets
* Server-sent Events
* Node Streams
* Service Workers
* jQuery Events
* XMLHttpRequest
* setInterval

#### Observables

`Observable === Collection + Time`

Reactive Extensions (RxJS - Reactive Extensions Library for JavaScript, `rx.js`):
* http://reactivex.io/
* https://github.com/ReactiveX/rxjs
* Events as Streams
* Open Source (Apache2)
* Ported ot many languages
  * C
  * .Net
  * JavaScript
  * Java (Netflix)
  * Objective-C
