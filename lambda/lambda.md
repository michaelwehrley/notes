# Lambda & Functions as a Service

There is no state (like its name!).  functions subscribe to an event, run when invoked and then shut down.  Serves are always on and always listening.

* Amazon's function as a service: `lambda`
* Other providers have a "functions as a service" (i.e., AWS, Azure, Google, Firebase, Kubeless, Spotinist, Cloudflare).

## Serverless

* "Serverless" is not always the framework people are using.

* https://serverless.com/

Creating a serverless
* `sls create`
* `sls create -t aws-nodejs -p demo`

`handler.js` is like the "main" function.


You can invoke the function: `sls invoke local -f hello`
```json
{
    "statusCode": 200,
    "body": "{\"message\":\"Go Serverless v1.0! Your function executed successfully!\",\"input\":\"\"}"
}
```

#### Setting up Handlers

```yml
# serverless.yml
functions:
  helloworld:
    handler: "src/helloworld.handler"
```

```js
// src/helloworld.js
module.exports.handler = (evt, ctx, done) => {
  return done(null, evt); // null is error message, and `evt` is on success
};
```

```json
// src/event.json
{
  "message": "hello"
}
```

`sls invoke local -f helloworld -p /Users/mike/Github/serverless-with-aws/src/event.json`

```json
{
    "message": "hello"
}
```

#### Sync Lambda vs Async in Lambda
* Sync is like an API call - we wait for the response.
* Async we never care - like sending an email.
