# Progamming Style and Your Brain

Daniel Kahneman - Head & Gut

## Javascript

### Semicolon insertion
* Meant for new developers, but styled/influenced by C 
return
{
  ok: false 
}

return;
{
  ok: false;
};

vs

return {
  ok: false
}

### `switch` Statement
* It is essentially a `goto` function - no longer helpful
* Fallthrough error
* Causes an implicit coupling of code
* fallthroughs do happen 

### Immediately Invocable Function Expression
* If we move parentheses inside, it is more clear what we care about
* results of function matters
(function() {
  ...
}())

### Block Scope
block scope vs function scope
* ruby has block scope.. `do ... end`

### `new` prefix
* Forgetting `new` cuases constructo to clobber global variables w/o warning
* Fixed in ES5/strict
* Construction function should be Capitalized

### Curly Braces
* Parentheses around the condition are required
* Unix was developed by Ken Thompson, Dennis Ritchie, and Brian Kernighan
* From B language (1969, .b, Ken Thompson)
* B was influenced by BCPL (1966; influenced by CPL (influenced by ALGOL 60))
* BCPL was first curly braces - curly braces around the consequence were required
* It looked more like Fortran (1957) 


### Bad Style
* `x += 1` is more clear than `x++` and there isn't confusion with `++x`

