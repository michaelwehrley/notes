# AWS

https://luvactually.com

## EC2 - Elastic Compute Cloud

* A rentable virtual computer on which you can run Windows or Linux and install whatever software you wish.  This includes a web server running Rails and a database server.

## Route 53

luvactually.com

## S3 - Simple Storage Service

* It looks like a folder structure, but it is a Key/Value store. You are charged for storage and requests.

* Typically used to store large binary files. Amazon also has other storage and database services, like RDS for relational databases and DynamoDB for NoSQL.

* POSTs are immediate and 200 response, while PUTs and DELETEs are eventually consistent.

* You can create a different bucket for every site or environment you want to deploy.
  1. Staging
  2. Production
  3. E2E testing
  4. Every PR could have their own bucket.

* There are *buckets* where you can put *read* files.
  * You can *host* web pages out of your buckets.
  * They can be 0 bytes or 5 terabytes
  * Scalable
  * Durable & Available
  * Add Images (for like sending images in an email)
  * Other features: encryption, versioning, security, lifecycel managment

* Storage Tiers
  * Standard
  * Infrequently accessed (maybe our CSVs)
  * Reduced Redundancy
  * `Glacier` - super increquently accessed (technically not really S3)

### Policies

We need to make this accessible.
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*", // Anyone `*`
      "Action": "s3GetObject", // to get
      "Resource": "arn:aws:s3:::YOUR_BUCKET_NAME_HERE/*" // any file (wildcard) in this bucket `*`
    }
  ]
}
```

### Configuring S3 Bucket

`aws configure`
AWS Access Key ID [********************]: 
AWS Secret Access Key [********************]: 
Default region name [us-east-1]: 
Default output format [json]:

```
ls ~/.aws/
config    credentials
```

```
cat ~/.aws/config 
[default]
output = json
region = us-east-1
```

```
cat ~/.aws/credentials
[default]
aws_access_key_id = ********************
aws_secret_access_key = ********************
```

### CLI

```
aws s3 ls s3://luvactually.com
2018-11-23 20:18:47        151 index.html
```

Adding all files in the `dist` directory to S3

`aws s3 cp dist/ s3://luvactually.com --recursive`

## Cloudfront (i.e., a remote CDN)

Globally distribute (which takes awhile) your website around the globe.

Aftering creating the distribution you will get `http://dk0d8k3h9ijvf.cloudfront.net/`

Change the A (alias) name:
* Change `luvactually.com` from aliasing to `s3-website-us-east-1.amazonaws.com` to `dk0d8k3h9ijvf.cloudfront.net`
* Change `www.luvactually.com` from aliasing to `s3-website-us-east-1.amazonaws.com` to `dk0d8k3h9ijvf.cloudfront.net`

Not only does it make it faster b/c of the nodes, but it caches your site and thus is cheaper for S3 - less requests.

## Lambda@Edge

* A *distributed* lambda.
* Allows to basically put a simplifed/limited Lambda (i.e., function) at each node that Cloudfront provides.
* Lambda Edge is between 5-30 seconds while typical Lambda is update 5 minutes.  Way less memory.
* Logs can be tricky as they are where the closest server was, but that may vary.

Where `Lamba@Edge` allows you to add a function:
1. Viewer Request (i.e., End User => CloudFront cache) - *5 seconds to execute*
  * Execute on every request before CloudFront's cache is checked.
  * Modify the cache key (URL, cookies, headers, query string).
  * Make additional network calls.
  * Generate responses (uncached).
1. Viewer Response (i.e., End User <= CloudFront cache)
  * Executed on all requests after a response is received from the origin or cache.
  * Modify the response headers ewithout catching the result.
  * Make external network calls.
1. Origin Request (i.e., CloudFront Cache => Origin Server) - *30 seconds to execute*
  * Executed on a cahce miss, before the rquest is forwareed to the origin/
  * You can make exteranl network calls.
  * Re-write URLs (pretty URLs)
  * Cool for stuff like internationalization.
1. Origin Response (i.e., CloudFront Cache <= Origin Server)
  * Response from the origin that haven't been cached yet.
  * Executed on cache miss, after a response is received from the origin.
  * Make external network calls.
  * Modify response headers prior to caching.

### Testing

Lambda@Edge Event Structure: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-event-structure.html

* Request Event: `https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-event-structure.html#lambda-event-structure-request`

Silly Example in how to update EVERY request before it hits CloudFront.
```js
exports.handler = (event, context, callback) => {
  const request = event.Records[0].cf.request;

  if (/notes\/\d+/.test(request.uri)) {
    request.uri = "/index.html";
  }

  if (request.uri === "/prince-1.jpg") {
    request.uri = "/prince-2.jpg";
  }

  callback(null, request);
};

```

Example of updating the Response to be more secure for instance: https://observatory.mozilla.org/analyze/luvactually.com

```js
'use strict';

exports.handler = (event, context, callback) => {
  const response = event.Records[0].cf.response;

  response.headers['strict-transport-security'] = [{
    key: 'Strict-Transport-Security',
    value: 'max-age=31536000; includeSubDomains'
  }];

  response.headers['content-security-policy'] = [{
    key: 'Content-Security-Policy',
    value: "default-src 'self'"
  }];

  response.headers['x-xss-protection'] = [{
    key: 'X-XSS-Protection',
    value: '1; mode=block'
  }];

  response.headers['x-content-type-options'] = [{
    key: 'X-Content-Type-Options',
    value: 'nosniff'
  }];

  response.headers['x-frame-options'] = [{
    key: 'X-Frame-Options',
    value: 'DENY'
  }];

  callback(null, response);
};
```

## Terraform & CloudFormation

If you need more customization you can use CloudFormation which allows you to quickly and easily deploy your infrastructure resources and applications.
