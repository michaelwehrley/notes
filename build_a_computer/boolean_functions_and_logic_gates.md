# Boolean Functions and Logic Gates

## Boolean Identities

### Communative Laws

`(x AND y) = (y AND x)`

`(x OR y) = (y OR x)`

### Associative Laws

`(x AND (y AND z)) = ((x AND y) AND z))`

`(x OR (y OR z)) = ((x OR y) OR z)`

### Distributive Laws

`(x AND (y OR z)) = (x AND y) OR (x AND z)`

`(x OR (y AND z)) = (x OR y) AND (x OR z)`

### De Morgan Laws

`NOT(x AND y) = NOT(x) OR NOT(y)`

`NOT(x OR y) = NOT(x) AND NOT(y)`

## Boolean Algebra

...

### Truth Table to Boolean Functions

`NOT` Operator: `f(x) = NOT(x)`

| x | `f (x)` |
|---|---|
| 0 | 1 |
| 1 | 0 |

`AND` Operator: `f(x, y) = (x AND y)`

| x | y | `f And(x, y)` |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

`NAND` Operator: `f(x, y) = (x NAND y)`

* Any boolean expression can be represented using an expression containing only `NAND` operations.

| x | y | `f Nand(x,y)` |
|---|---|---|
| 0 | 0 | 1 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

## Logic Gates

### Elementary Logic Gates

#### Not(a)

|  in   |  `Not(a)`  |
|-|-|
|   0   |   1   |
|   1   |   0   |

```vhdl
/**
 * Not gate:
 * out = not in
 */

CHIP Not {
    IN in;
    OUT out;

    PARTS:
    Nand(a=in, b=true, out=out);
}
```

#### And(a, b)

|   a   |   b   |  `And(a, b)`  |
|-|-|-|
|   0   |   0   |   0   |
|   0   |   1   |   0   |
|   1   |   0   |   0   |
|   1   |   1   |   1   |

```vhdl
/**
 * And gate: 
 * out = 1 if (a == 1 and b == 1)
 *       0 otherwise
 */

CHIP And {
    IN a, b;
    OUT out;

    PARTS:
    Nand(a=a, b=b, out=nandout);
    Not(in=nandout, out=out);
}
```

#### Or(a, b)

|   a   |   b   |  `Or(a, b)`  |
|-|-|-|
|   0   |   0   |   0   |
|   0   |   1   |   1   |
|   1   |   0   |   1   |
|   1   |   1   |   1   |

```vhdl
 /**
 * Or gate:
 * out = 1 if (a == 1 or b == 1)
 *       0 otherwise
 */

CHIP Or {
    IN a, b;
    OUT out;

    PARTS:
    Not(in=a, out=nota);
    Not(in=b, out=notb);
    Nand(a=nota, b=notb, out=out);
}
```

#### Xor(a, b)

|   a   |   b   |  `Xor(a, b)`  |
|-|-|-|
|   0   |   0   |   0   |
|   0   |   1   |   1   |
|   1   |   0   |   1   |
|   1   |   1   |   0   |

```vhdl
/**
 * Exclusive-or gate:
 * out = not (a == b)
 */

CHIP Xor {
    IN a, b;
    OUT out;

    PARTS:
    Not(in=a, out=NotA);
    And(a=NotA, b=b, out=NotAAndB);
    Not(in=b, out=NotB);
    And(a=NotB, b=a, out=NotBAndA);
    Or(a=NotAAndB, b=NotBAndA, out=out);
}
```

#### Mux(a, b, sel)

A **Multiplexor** enables **selecting** and outputting on of two possible inputs. It allows for a gate to return either be an `And` gate or `Or` gate for instance; i.e., a **programmable gate**.

|   a   |   b   |  sel  |  `Mux(a, b, sel)`  |
|-|-|-|-|
|   0   |   0   |   0   |   0   |
|   0   |   0   |   1   |   0   |
|   0   |   1   |   0   |   0   |
|   0   |   1   |   1   |   1   |
|   1   |   0   |   0   |   1   |
|   1   |   0   |   1   |   0   |
|   1   |   1   |   0   |   1   |
|   1   |   1   |   1   |   1   |


```
if (sel == 0)
  out = a
else
  out = b
```

```vhdl
/** 
 * Multiplexor:
 * out = a if sel == 0
 *       b otherwise
 */

CHIP Mux {
    IN a, b, sel;
    OUT out;

    PARTS:
    Not(in=b, out=notB);
    And(a=a, b=notB, out=selNotAAndNotB);
    And(a=a, b=b, out=selNotAAndB);
    Or(a=selNotAAndNotB, b=selNotAAndB, out=selFalse);

    Not(in=sel, out=notSel);
    And(a=selFalse, b=notSel, out=AndSelFalse);

    Not(in=a, out=notA);
    And(a=notA, b=b, out=selTrueNotAAndB);
    And(a=a, b=b, out=selTrueAAndB);
    Or(a=selTrueNotAAndB, b=selTrueAAndB, out=selTrue);

    And(a=selTrue, b=sel, out=AndSelTrue);

    Or(a=AndSelFalse, b=AndSelTrue, out=out);
}
```

#### DMux(a, b, sel)

A **Demultiplexer** takes a single input line and routes it to one of several digital output lines.

|  in   |  sel  |   a   |   b   |
|-|-|-|-|
|   0   |   0   |   0   |   0   |
|   1   |   0   |   1   |   0   |
|   0   |   1   |   0   |   0   |
|   1   |   1   |   0   |   1   |

```vhdl
/**
 * Demultiplexer:
 * {a, b} = {in, 0} if sel == 0
 *          {0, in} if sel == 1
 */

CHIP DMux {
    IN in, sel;
    OUT a, b;

    PARTS:
    Not(in=sel, out=notSel);
    And(a=in, b=notSel, out=a);

    And(a=in, b=sel, out=b);
}
```

### 16-bit Variants

### Multi-Way Variants
