# History

* 1804: Joseph Marie Jacquard demonstrated a mechanism to automate loom operation w/ *punch cards* Just like in a loom, a 0 is something, just not 1 or open.  It is "closed" - and impacts the loom's logic.  With computers, a computer would read a hole as 1 and no hole as a 0.  Today, we use transistors.

* 1950s: Assembly

* 1952: IBM 701
  - IBM’s first commercial scientific computer
  - **Vacuum tube** logic circuitry and electrostatic storage, consisting of 72 Williams tubes with a capacity of 1024 bits each, giving a total memory of 2048 words of 36 bits each.

* 1954: IBM 704
  - First mass-produced computer with floating-point arithmetic hardware
  - vacuum tube logic circuitry

* 1956: IPL (Information Processing Language)
  - Assembly paradigm
  - Focus on symbols & lists with Assemnbly-like syntax

* 1957: FORTRAN (Formula Translation)
  - IBM (John Backus) writes FORTRAN for math calculations
  - built for the IBM 704
  - The Fortran Automatic Coding System for the IBM 704 (15 October 1956), the first Programmer's Reference Manual for Fortran

* 1958: LISP (LISt Processor)
  - Influenced by the notation of Alonzo Church's **lambda calculus**

* 1959: COBOL
  - Grace Hopper inspired this lanuage
  - **Portable** language: Improvement over FORTRAN in that it could run the same data processing programs on different computers: numbers and string inputs.

* 1959: FLPL (Fortran-Compiled List-Processing Language)
  - Built on top of FORTRAN to manipulate symbols nad lists

* 1960s - 1970s: Database modeling developed by IBM

* 1970s: Steve Wozniak and Steve Jobs invented Apple I

* Late 1970s - IBM develops SQL (compare to other query languages at the time: QUEL & QBE).

* 1980s: MS DOS: Microsoft *Disk Operating System*
* 1972: Pong & Atari & Aracde games
* 1977-1985: UC Berkeley devevloped the relational database called _Ingres_
* 1994: SQL features were added to Postgres and it was called Postgres95
* 1996: Postgres95 was updated to PostgreSQL

## Macintosh / Microsoft / Unix / GNU
Operating Systems: https://commons.wikimedia.org/wiki/File:Unix_timeline.en.svg
*Disk Operating System* is a way to store info on a disk.

### Apple
* https://en.wikipedia.org/wiki/List_of_Apple_operating_systems
* Apple I/1976 - built by Wozniak: There was no OS for the Apple I.
* Apple II/1977: Apple DOS (*Disk Operating System*) is the first operating system for Apple computers. 8-bit home computer, 
* 1984:  "Classic" Mac OS

### Microsoft
* 1980s: MS DOS: Microsoft *Disk Operating System*

### Unix
* 1970s at the Bell (AT&T) Labs & one of the earliest OS
* Ken Thompson and Dennis Ritchie
  - Ken Thompson invented the B programming language (direct predecessor to C) along with co-inventing the Go programming language.
  - Create C programming language

### GNU - GNU's Not Unix! (recursive_acronym)
* GNU: Richard Stallman
* Not really an OS but a set of rules that allows for the development of open source tools and OS
* Free operating system based on Unix
* Linux Kernel + GNU tools = Linux OS

## ASCII => UTF-8
* **values out of our 256** (i.e., 8 BITs or 1 BYTE) and it last a veerrrrryyyy long time!
* http://www.asciitable.com/
* First character encoding - a way to translate 0s and 1s into letters (binary table)
* Ex: First character was 

ASCII | Binary  | Decimal | Hex | Base64
------|---------|---------|-----|-------
a     | 01100001| 097     |0x61 |YQ==

* **UTF-8** (binary)allows us to user a **VARIABLE number** of **BYTES**
* UTF-8 includes ASCII and a UTF standard
* ☺ = 11100010:10011000:10111010

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

