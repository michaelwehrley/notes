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

Allows for us to pass in 16 bits:

<img src="https://github.com/michaelwehrley/notes/blob/master/assets/And16.png" width=500>

#### Not16

```vhdl
/**
 * 16-bit Not:
 * for i=0..15: out[i] = not in[i]
 */

CHIP Not16 {
    IN in[16];
    OUT out[16];

    PARTS:
    Not(in=in[0], out=out[0]);
    Not(in=in[1], out=out[1]);
    Not(in=in[2], out=out[2]);
    Not(in=in[3], out=out[3]);
    Not(in=in[4], out=out[4]);
    Not(in=in[5], out=out[5]);
    Not(in=in[6], out=out[6]);
    Not(in=in[7], out=out[7]);
    Not(in=in[8], out=out[8]);
    Not(in=in[9], out=out[9]);
    Not(in=in[10], out=out[10]);
    Not(in=in[11], out=out[11]);
    Not(in=in[12], out=out[12]);
    Not(in=in[13], out=out[13]);
    Not(in=in[14], out=out[14]);
    Not(in=in[15], out=out[15]);
}
```

#### And16
```vhdl
/**
 * 16-bit bitwise And:
 * for i = 0..15: out[i] = (a[i] and b[i])
 */

CHIP And16 {
    IN a[16], b[16];
    OUT out[16];

    PARTS:
    And(a=a[0], b=b[0], out=out[0]);
    And(a=a[1], b=b[1], out=out[1]);
    And(a=a[2], b=b[2], out=out[2]);
    And(a=a[3], b=b[3], out=out[3]);
    And(a=a[4], b=b[4], out=out[4]);
    And(a=a[5], b=b[5], out=out[5]);
    And(a=a[6], b=b[6], out=out[6]);
    And(a=a[7], b=b[7], out=out[7]);
    And(a=a[8], b=b[8], out=out[8]);
    And(a=a[9], b=b[9], out=out[9]);
    And(a=a[10], b=b[10], out=out[10]);
    And(a=a[11], b=b[11], out=out[11]);
    And(a=a[12], b=b[12], out=out[12]);
    And(a=a[13], b=b[13], out=out[13]);
    And(a=a[14], b=b[14], out=out[14]);
    And(a=a[15], b=b[15], out=out[15]);
}
```

#### Or16

```vhdl
/**
 * 16-bit bitwise Or:
 * for i = 0..15 out[i] = (a[i] or b[i])
 */

CHIP Or16 {
    IN a[16], b[16];
    OUT out[16];

    PARTS:
    Or(a=a[0], b=b[0], out=out[0]);
    Or(a=a[1], b=b[1], out=out[1]);
    Or(a=a[2], b=b[2], out=out[2]);
    Or(a=a[3], b=b[3], out=out[3]);
    Or(a=a[4], b=b[4], out=out[4]);
    Or(a=a[5], b=b[5], out=out[5]);
    Or(a=a[6], b=b[6], out=out[6]);
    Or(a=a[7], b=b[7], out=out[7]);
    Or(a=a[8], b=b[8], out=out[8]);
    Or(a=a[9], b=b[9], out=out[9]);
    Or(a=a[10], b=b[10], out=out[10]);
    Or(a=a[11], b=b[11], out=out[11]);
    Or(a=a[12], b=b[12], out=out[12]);
    Or(a=a[13], b=b[13], out=out[13]);
    Or(a=a[14], b=b[14], out=out[14]);
    Or(a=a[15], b=b[15], out=out[15]);
}
```

#### Mux16

```vhdl
/**
 * 16-bit multiplexor: 
 * for i = 0..15 out[i] = a[i] if sel == 0 
 *                        b[i] if sel == 1
 */

CHIP Mux16 {
    IN a[16], b[16], sel;
    OUT out[16];

    PARTS:
    Mux(a=a[0], b=b[0], sel=sel, out=out[0]);
    Mux(a=a[1], b=b[1], sel=sel, out=out[1]);
    Mux(a=a[2], b=b[2], sel=sel, out=out[2]);
    Mux(a=a[3], b=b[3], sel=sel, out=out[3]);
    Mux(a=a[4], b=b[4], sel=sel, out=out[4]);
    Mux(a=a[5], b=b[5], sel=sel, out=out[5]);
    Mux(a=a[6], b=b[6], sel=sel, out=out[6]);
    Mux(a=a[7], b=b[7], sel=sel, out=out[7]);
    Mux(a=a[8], b=b[8], sel=sel, out=out[8]);
    Mux(a=a[9], b=b[9], sel=sel, out=out[9]);
    Mux(a=a[10], b=b[10], sel=sel, out=out[10]);
    Mux(a=a[11], b=b[11], sel=sel, out=out[11]);
    Mux(a=a[12], b=b[12], sel=sel, out=out[12]);
    Mux(a=a[13], b=b[13], sel=sel, out=out[13]);
    Mux(a=a[14], b=b[14], sel=sel, out=out[14]);
    Mux(a=a[15], b=b[15], sel=sel, out=out[15]);
}
```

### Multi-Way Variants

#### Or8Way

```vhdl
/**
 * 8-way Or: 
 * out = (in[0] or in[1] or ... or in[7])
 */

CHIP Or8Way {
    IN in[8];
    OUT out;

    PARTS:
    Or(a=in[0], b=in[1], out=a1);
    Or(a=a1, b=in[2], out=a2);
    Or(a=a2, b=in[3], out=a3);
    Or(a=a3, b=in[4], out=a4);
    Or(a=a4, b=in[5], out=a5);
    Or(a=a5, b=in[6], out=a6);
    Or(a=a6, b=in[7], out=out);
}
```

#### Mux4Way16

```vhdl
/**
 * 4-way 16-bit multiplexor:
 * out = a if sel == 00
 *       b if sel == 01
 *       c if sel == 10
 *       d if sel == 11
 */

CHIP Mux4Way16 {
    IN a[16], b[16], c[16], d[16], sel[2];
    OUT out[16];

    PARTS:
    /** 
     * Multiplexor:
     * out = a if sel == 0
     *       b otherwise
     */

    /* sel == 00 */

    Not(in=sel[0], out=sel000a);
    Not(in=sel[1], out=sel000b);
    And(a=sel000a, b=sel000b, out=sel00);

    /**
    * sel == 01
    * sel[1] == the 0 in 01
    * sel[0] == the 1 in 01
    */

    Not(in=sel[1], out=sel011);
    And(a=sel011, b=sel[0], out=sel01);

    Mux(a=a[0], b=b[0], sel=sel01, out=muxAB0);
    Mux(a=a[1], b=b[1], sel=sel01, out=muxAB1);
    Mux(a=a[2], b=b[2], sel=sel01, out=muxAB2);
    Mux(a=a[3], b=b[3], sel=sel01, out=muxAB3);
    Mux(a=a[4], b=b[4], sel=sel01, out=muxAB4);
    Mux(a=a[5], b=b[5], sel=sel01, out=muxAB5);
    Mux(a=a[6], b=b[6], sel=sel01, out=muxAB6);
    Mux(a=a[7], b=b[7], sel=sel01, out=muxAB7);
    Mux(a=a[8], b=b[8], sel=sel01, out=muxAB8);
    Mux(a=a[9], b=b[9], sel=sel01, out=muxAB9);
    Mux(a=a[10], b=b[10], sel=sel01, out=muxAB10);
    Mux(a=a[11], b=b[11], sel=sel01, out=muxAB11);
    Mux(a=a[12], b=b[12], sel=sel01, out=muxAB12);
    Mux(a=a[13], b=b[13], sel=sel01, out=muxAB13);
    Mux(a=a[14], b=b[14], sel=sel01, out=muxAB14);
    Mux(a=a[15], b=b[15], sel=sel01, out=muxAB15);

    /**
    * 10
    * sel[0] == the 0 in 10
    * sel[1] == the 1 in 10
    */

    Not(in=sel[0], out=sel101);
    And(a=sel[1], b=sel101, out=sel10);

    /* sel == 11 */

    And(a=sel[0], b=sel[1], out=sel11);

    Mux(a=c[0], b=d[0], sel=sel11, out=muxCD0);
    Mux(a=c[1], b=d[1], sel=sel11, out=muxCD1);
    Mux(a=c[2], b=d[2], sel=sel11, out=muxCD2);
    Mux(a=c[3], b=d[3], sel=sel11, out=muxCD3);
    Mux(a=c[4], b=d[4], sel=sel11, out=muxCD4);
    Mux(a=c[5], b=d[5], sel=sel11, out=muxCD5);
    Mux(a=c[6], b=d[6], sel=sel11, out=muxCD6);
    Mux(a=c[7], b=d[7], sel=sel11, out=muxCD7);
    Mux(a=c[8], b=d[8], sel=sel11, out=muxCD8);
    Mux(a=c[9], b=d[9], sel=sel11, out=muxCD9);
    Mux(a=c[10], b=d[10], sel=sel11, out=muxCD10);
    Mux(a=c[11], b=d[11], sel=sel11, out=muxCD11);
    Mux(a=c[12], b=d[12], sel=sel11, out=muxCD12);
    Mux(a=c[13], b=d[13], sel=sel11, out=muxCD13);
    Mux(a=c[14], b=d[14], sel=sel11, out=muxCD14);
    Mux(a=c[15], b=d[15], sel=sel11, out=muxCD15);

    /* sel == 00 or sel == 01 */

    Or(a=sel00, b=sel01, out=sel00Or01);

    /* sel == 10 or sel == 11 */

    Or(a=sel10, b=sel11, out=sel10Or11);

    Mux(a=muxAB0, b=muxCD0, sel=sel10Or11, out=out[0]);
    Mux(a=muxAB1, b=muxCD1, sel=sel10Or11, out=out[1]);
    Mux(a=muxAB2, b=muxCD2, sel=sel10Or11, out=out[2]);
    Mux(a=muxAB3, b=muxCD3, sel=sel10Or11, out=out[3]);
    Mux(a=muxAB4, b=muxCD4, sel=sel10Or11, out=out[4]);
    Mux(a=muxAB5, b=muxCD5, sel=sel10Or11, out=out[5]);
    Mux(a=muxAB6, b=muxCD6, sel=sel10Or11, out=out[6]);
    Mux(a=muxAB7, b=muxCD7, sel=sel10Or11, out=out[7]);
    Mux(a=muxAB8, b=muxCD8, sel=sel10Or11, out=out[8]);
    Mux(a=muxAB9, b=muxCD9, sel=sel10Or11, out=out[9]);
    Mux(a=muxAB10, b=muxCD10, sel=sel10Or11, out=out[10]);
    Mux(a=muxAB11, b=muxCD11, sel=sel10Or11, out=out[11]);
    Mux(a=muxAB12, b=muxCD12, sel=sel10Or11, out=out[12]);
    Mux(a=muxAB13, b=muxCD13, sel=sel10Or11, out=out[13]);
    Mux(a=muxAB14, b=muxCD14, sel=sel10Or11, out=out[14]);
    Mux(a=muxAB15, b=muxCD15, sel=sel10Or11, out=out[15]);
}
```

#### Mux8Way16