# Types and Casting

## ~~Strongly or Weakly~~ Safety Typed Languages
This concept is more accurately understood as the presence or absence of type safety, memory safety, static type-checking, or dynamic type-checking.

## Static Type-Checking

A "strong type system" is described as one in which there is no possibility of an unchecked runtime type error. The absence of unchecked run-time errors is referred to as safety or type safety.[1](https://en.wikipedia.org/wiki/Strong_and_weak_typing#Static_type-checking)

Therefore, the type of a variable is known at compile time. *C* and *Java* are examples.
However, C supports more types of _implicit_ conversions and
C allows for pointer values to be _explicitly_ cast while Java and Pascal do not.

```C
// cast.c
// mac OS X
// Compile via `$ gcc cast.c`
// Execute via `$ ./a.out`
#include <stdio.h>

int main() {

   int  i = 17;
   char c = 'c'; // ascii value is 99
   int sum;

   sum = i + c;
   printf("Value of sum : %d\n", sum );

   return 0;
}
```

```C
// cast.c
// mac OS X
// Compile via `$ gcc cast.c`
// Execute via `$ ./a.out`

#include <stdio.h>

int main()
{
  int i = 65;

  printf("place in memory %p\n", &i); // 0x7fff5abe2698
  printf("print as an int: %d\n", i); // 65
  printf("print as an int: %i\n", i); // 65 - same as %d when using `printf`
  printf("print as a char: %c\n", i); // A
  printf("cast as a char before using printf: %c\n", (char)i); // A
  printf("print as a hex %x\n", i); // 41
  printf("print as a octal %o\n", i); // 101

  return 0;
}
```

## Dynamic Type-Checking / Duck Typing

Ruby is "strongly typed" in the sense that typing errors are prevented at runtime and they do little implicit type conversion, but these languages make no use of static type checking: the compiler does not check or enforce type constraint rules.

Additionally, ruby doesn't support casting per se.

The term duck typing is now used to describe the dynamic typing paradigm.

```Ruby
def add(value)
  value + 1
end

def subtract(value)
  value - 1
end

add("a")
# TypeError: no implicit conversion of Fixnum into String
# 	from (irb):1:in `+'
# 	from (irb):1:in `run'
# 	from (irb):2

subtract("a") # NoMethodError: undefined method `-' for "a":String
```

Ruby *behaves* like a strongly typed language most of the time.
The solution is change the type:

```Ruby
"3".to_i + 4 # 7
```

![Ruby behaves like a strongly typed language](/assets/ruby_behaves_like_strongly_typed_language.jpg)

While JS is compiled, the type of a variable is determined at runtime makes many implicit conversions:

```JS
function add(value) {
  return value + 1;
}

function subtract(value) {
  return value - 1;
}

function implicitConversion() {
  return "5" * "2";
}

add("a"); // "a1"

subtract("a"); // NaN

implicitConversion() // 10
```

## Information Lost

```C
/* Casting can cause information to be lost*/

#include <stdio.h>

int main()
{
  double decimal = 65.8;

  printf("%f\n", decimal); // 65.800000
  printf("%p\n", &decimal); // 0x7fff59628690
  printf("%d\n", (int) decimal); // 65
  printf("%p\n", &decimal); // 0x7fff59628690
  printf("%f\n", (double)(int) decimal); // 65.000000
  printf("%p\n", &decimal); // 0x7fff59628690

  return 0;
}

```
