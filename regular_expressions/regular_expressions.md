# Regular Expressions

## Ken Thompson

Popular text editor for the Unix operating system at the time was [ed](https://en.wikipedia.org/wiki/Ed_(text_editor)).  Just a fun fact, this `ed` os was written in [PDP-11 Assembly language](https://en.wikipedia.org/wiki/PDP-11_architecture) and today `ed` is written in `C`.  But computers where so low on memory like 64 KB (not MB) that you couldn't load a file such as the [Feteralist Papers](https://en.wikipedia.org/wiki/The_Federalist_Papers) into memory and a do an analysis on it like [Lee McMahon](https://en.wikipedia.org/wiki/Lee_E._McMahon) wanted to do in order to do some natural language anaylsis on it to determine who wrote what.  The Federalist Papers when published were published anonymously under the pseudonym **Publius**.  Ken Thompson introduced regular expression in the *ed* text editor.  It would find something like `/prin/` and find "printed", "print", "princess", and "printed". So Lee contacted Ken Thompson b/c he wanted load all the papers in memory with `ed` and search with regular experssions.  Overnight, Ken Thompson wrote a program called `grep`.

In `ed` we had a `g` command just like we had commands `w` for *write*, `p` for *print*, `d` for *delete*, or `a` for *append*.  For example:
* Print the first line: `1 p`
* Print the lines 1-10: `1,10 p`
* Delete line 3: `3 d`
* Print last line `$ p`
* Delete last line `$ d`

Ken's new program was to leverage `g` and use the **regex** and then print the results:
* If searching for `prin` then `g/print/p`.
* Or more generally: `g/re/p`.

## JavaScript

Regular expression literals can be used to match or replace a pattern:

```JavaScript
var DATE_FORMAT = /^(0[1-9]|1[0-2])\/(0[1-9]|1[0-9]|2[0-9]|3[0-1])\/(\d{4})$/;
var matches = "01/11/2014".match(DATE_FORMAT);

matches[1] // month
matches[2] // day
matches[3] // year
```

Building a regular expression needed at runtime requires the `RegExp()` constructor:

```JavaScript
  var phrase = "Big Time!";
  var regEx;

  for(var i = 0; i < phrase.length; i++) {
    regEx = new RegExp(phrase[i], "g");

    phrase.match(regEx).length;
  }
```
An example: [isAnagram](./example.js)

*Note: Calling `RegEx()` as a function and not as a constructor behaves the same way* ([1](../../references.md))

Other options for a regular expression:
```JavaScript
// returns an array containing the entire match result and any parentheses-captured matched results
// null if there were no matches.
"foobarfoo".match(/foo/g);
// replaces the first found regex with second parameter (unless it is a global search)
"foobar".replace(re, "!");
// returns the index of the first match (even if it is a global search)
"foobar".search(re);

var RE = /^foo(bar)$/;
RE.test("foobar"); // true
```

Remember calling `replace` with a string option replaces only the *first* occurrence.
```JavaScript
"foobar".replace("o", "!"); // "f!obar"
```

## Gotcha

When writing multi-line comments, there can be an issue in that it will lead to breaking code:

```Javascript
/*
A RegExp

@param { regExp } The RegExp /a*/g
...
*/
```

## Ruby

("#{locale_prefix}#{url}" =~ /#{current_path}$/).present?
