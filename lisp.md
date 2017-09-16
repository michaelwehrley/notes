# LISP

## Install

We are installing [GNU CLISP 2.49 (2010-07-07)](http://clisp.cons.org/)

1. Install via Homebrew `brew install clisp`
1. Launch via `$ clisp`
1. Exit via `[1]> (exit)` or `[1]> (quit)`

## Basic Commands

1. `[1]> (/ 8 2)` => 4

## Functions

### Define Functions

Define a function using `DEFUN`: `(defun name (parameter-list) "Optional documentation string." body)`

Simple Averaging:
```lisp
(defun averagenum (n1 n2 n3 n4)
  (/ ( + n1 n2 n3 n4) 4)
)
```

```lisp
[1]> (defun averagenum (n1 n2 n3 n4) (/ ( + n1 n2 n3 n4) 4))
AVERAGENUM
[2]> (averagenum 1 2 3 4)
5/2
```

### Functions With Parameters

```lisp
[1]> (defun adding-formula (a b) (+ a b))
ADDING-FORMULA
[2]> (adding-formula 4 8)
12
```

```lisp
[1]> (defun adding-formula3 (a b c) (+ a b c))
ADDING-FORMULA3
[2]> (adding-formula3 4 8 12)
24
```

### Variables

Setting global variables `SETQ`:

```lisp
[1]> (setq one 1)
1
```

Note the last `PRINC` - we don't this function to return anything to the user: it is a sub-routine.
