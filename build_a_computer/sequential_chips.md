# Sequential Chips

These are different from [combinational chips](./boolean_arithmetic_and_alu.md) where logic happens *instantaneously*.
In sequential chips the logic is dependent on *time*.

## Random Access Memory (RAM)

RAM is a sequential chip. It has clocked behavior.

At any given point, only one *register* is in the RAM is selected either read from or change. 

## Register

## PC

![PC Sequential Chip](/assets/build_a_computer/PC.jpg)

```hdl
CHIP PC {
    IN in[16],load,inc,reset;
    OUT out[16];

    PARTS:
    Or(a=load, b=inc, out=trigger1);
    Or(a=trigger1, b=reset, out=trigger2);
    Mux16(a=incOut, b=in, sel=load, out=Mux16Out1);
    Mux16(a=Mux16Out1, b=false, sel=reset, out=Mux16Out2);
    Register(in=Mux16Out2, load=trigger2, out=regOut, out=out);
    Inc16(in=regOut, out=incOut);
}
```