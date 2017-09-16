# And Then There Was JavaScript

## History of JS

* Self improved Smalltalk (a great OO programming language) by REMOVING classes!

1. Protocols for the internet at NCSA (UI Urbana-Champagne)
  * WAIS, Archie, Gopher, _FTP_, Finger, WWW
1. They wrote MOSAIC - build IMG tag `<image>`
1. Went to Netscape and built Navigator 2 (based of HyperCard)
1. HyperCard for the Internet
1. Brendan Eich - given 10 days; make it look like Java, something people like
1. Java + Scheme (which he originally wanted to build an interpreter for) + Self => LiveScript =>
1. Java was created.  Write your code to run on the JVM and not the operating system then we can liberated from Microsoft
1. Netscape says similiar thing: write your code to work in the browser, and we can be liberated from Microsoft
1. Netscape and Sun join forces and drop HotJava and Netscape calls it JavaScript
1. Microsoft reverse engineered JS and built Internet Explorer and called their JavaScript "JScript"
1. Netscape doesn't want to loose control of JavaScript b/c of the name went to W3C
1. W3C says go f' yourself so they went to ECMA to ask for a standard and this how ECMAScript got the name but based of Microsofts reverse engineering
1. Versions
  * 1999 ES3
  * 2009 ES5 (Default & Strict)
  * 2015 ES6

## Objects

* [keys] must be strings, but there is *Automatic type coercion*
* There are no classes, just prototypes
* Classification and taxonomy are not necessary
* Instead we have *Differential Inheritence* where objects *delegate*
* Prototypal Inheritence: build new objects with `Object.create(other_object/prototype)`
* Inherits from Object.prototype
* `Object.create(null)` will not inherit from `Object.prototype`

```js
var mother = {
  a: 1,
  b: 2
};

daughter = Object.create(mother);
daughter.b += 2;
daughter.c = 9;

```

## Numbers
* No integer type

* 64-bit binary floating point - IEEE754 Double (Java and Fortran)
Ex: 1 = 1.0E0 (decimal) = 0x3FF0000000000000 (hex) = Sign Exponent Mantissa 0 01111111111 0000000000000000000000000000000000000000000000000000
* Fortran wanted more precision so it added 2 reals together; then C shortened it from "double precision" and called it "double"
* However, `Number.MAX_SAFE_INTEGER + 1 === Number.MAX_SAFE_INTEGER + 2`

## Browser (original web browser)
1. Feed it with a url...
1. Fetch => gets and put it in the cache
1. Parse => parses and turns it into a tree
1. Flow => will create a display list
1. Paint => paint engine creates it in pixels
* MOSAIC - added the IMG tag, but it was taking *forever* for everyone else
* Netscape - Mozilla to kill MOSAIC by putting a placeholder in the tree for images!

## Nodes
* `document.getElementById(id);`
* `document.getElementByName(name);`
* `document.getElementByTagName(tagName);`
* retrieve `<img>`
* node.property = expression (property such as `src`)
* W3C liked Java more than JS (remember they said die) and longer methods such as 
  - `getAttribute('complete')` instead of `my_image.complete`
  - `getPropertyValue(stylename)` - another example of JAVA API by W3C

* Style vs DOM naming conventions; Example: `background-color` vs `backgroundColor`
* Linking and Removing nodes: `node.clone()` - built by Java developers - tell parent etc
* Favor cleaner code over performance unless in necessary conditions 

## DOM & BOM
* Before javascript, in the browser there was a tree but no need way or API) to access the tree - no DOM, just browser
* The DOM is a subset of the browser
* DOM API would be something like `getElementsByTagName` and `createElement`. Instead, use a library like jQuery - abstraction over the DOM
* Awful to work with DOM b/c different implementation in different browsers
* Javascript is most popular client-side DOM manipulator, but there server-side languages like  Nokogiri?

