# JS Asynchronicity

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
* Creates a Promise object `{value: ..., c: [...]}`
* XMLHTTPRequest in the Web Browser (`XHR`) - unlike the `Timer` we used for `setTimeout`
4. `futureData` is set to `{value: ...., onFulfillment: []}`
5. One fulfilled, we want the response of `fetch` to update the property `value` of `futureData`
6. Trigger all functions in `futureData`
