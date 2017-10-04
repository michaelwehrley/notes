# Boolean Arithmetic & ALU

## Combinational Chips

### Half Adder

```vhdl
/**
 * Computes the sum of two bits.
 */

CHIP HalfAdder {
    IN a, b;    // 1-bit inputs
    OUT sum,    // Right bit of a + b 
        carry;  // Left bit of a + b

    PARTS:
    And(a=a, b=b, out=carry);
    Xor(a=a, b=b, out=sum);
}
```

### Full Adder

```vhdl
/**
 * Computes the sum of three bits.
 */

CHIP FullAdder {
    IN a, b, c;  // 1-bit inputs
    OUT sum,     // Right bit of a + b + c
        carry;   // Left bit of a + b + c

    PARTS:
    HalfAdder(a=a, b=b, sum=sum1, carry=carry1);
    HalfAdder(a=c, b=sum1, sum=sum, carry=carry2);
    Or(a=carry1, b=carry2, out=carry);
}

```

### 16-bit Adder

```vhdl
/**
 * Adds two 16-bit values.
 * The most significant carry bit is ignored.
 */

CHIP Add16 {
    IN a[16], b[16];
    OUT out[16];

    PARTS:
    FullAdder(a=a[0], b=b[0], c=false, sum=out[0], carry=carry0);
    FullAdder(a=a[1], b=b[1], c=carry0, sum=out[1], carry=carry1);
    FullAdder(a=a[2], b=b[2], c=carry1, sum=out[2], carry=carry2);
    FullAdder(a=a[3], b=b[3], c=carry2, sum=out[3], carry=carry3);
    FullAdder(a=a[4], b=b[4], c=carry3, sum=out[4], carry=carry4);
    FullAdder(a=a[5], b=b[5], c=carry4, sum=out[5], carry=carry5);
    FullAdder(a=a[6], b=b[6], c=carry5, sum=out[6], carry=carry6);
    FullAdder(a=a[7], b=b[7], c=carry6, sum=out[7], carry=carry7);
    FullAdder(a=a[8], b=b[8], c=carry7, sum=out[8], carry=carry8);
    FullAdder(a=a[9], b=b[9], c=carry8, sum=out[9], carry=carry9);
    FullAdder(a=a[10], b=b[10], c=carry9, sum=out[10], carry=carry10);
    FullAdder(a=a[11], b=b[11], c=carry10, sum=out[11], carry=carry11);
    FullAdder(a=a[12], b=b[12], c=carry11, sum=out[12], carry=carry12);
    FullAdder(a=a[13], b=b[13], c=carry12, sum=out[13], carry=carry13);
    FullAdder(a=a[14], b=b[14], c=carry13, sum=out[14], carry=carry14);
    FullAdder(a=a[15], b=b[15], c=carry14, sum=out[15], carry=false);
}
```


### 16-bit incrementer

```vhdl
/**
 * 16-bit incrementer:
 * out = in + 1 (arithmetic addition)
 */

CHIP Inc16 {
    IN in[16];
    OUT out[16];

    PARTS:
    FullAdder(a=in[0], b=true, c=false, sum=out[0], carry=carry0);
    FullAdder(a=in[1], b=false, c=carry0, sum=out[1], carry=carry1);
    FullAdder(a=in[2], b=false, c=carry1, sum=out[2], carry=carry2);
    FullAdder(a=in[3], b=false, c=carry2, sum=out[3], carry=carry3);
    FullAdder(a=in[4], b=false, c=carry3, sum=out[4], carry=carry4);
    FullAdder(a=in[5], b=false, c=carry4, sum=out[5], carry=carry5);
    FullAdder(a=in[6], b=false, c=carry5, sum=out[6], carry=carry6);
    FullAdder(a=in[7], b=false, c=carry6, sum=out[7], carry=carry7);
    FullAdder(a=in[8], b=false, c=carry7, sum=out[8], carry=carry8);
    FullAdder(a=in[9], b=false, c=carry8, sum=out[9], carry=carry9);
    FullAdder(a=in[10], b=false, c=carry9, sum=out[10], carry=carry10);
    FullAdder(a=in[11], b=false, c=carry10, sum=out[11], carry=carry11);
    FullAdder(a=in[12], b=false, c=carry11, sum=out[12], carry=carry12);
    FullAdder(a=in[13], b=false, c=carry12, sum=out[13], carry=carry13);
    FullAdder(a=in[14], b=false, c=carry13, sum=out[14], carry=carry14);
    FullAdder(a=in[15], b=false, c=carry14, sum=out[15], carry=false);
}
```

### Arithmetic Logic Unit (without handling of status outputs)

### Arithmetic Logic Unit (complete)
