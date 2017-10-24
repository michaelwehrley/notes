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

## Memory

When building a computer, the memory is one of, if not the most costly part.  The *faster* or *larger* the memory the more expensive.  Is it worth it to spend that money there or with the processor.

The solution is typically a large, cheap memory with a small, fastm and expensive memory.

Therefore, the data that is used by the processor is usually stored in the cheap faster memory and the memory that is rarely used resides in the larger slower memory.  The faster and smaller memory is called a *Cache*. 

All of these types of memory: the RAM, ROM, and Cache all look alike.  They all behave like a sequence of registers that are addressable and we can access anyone of these registers and do something with the bit contnent of these registers.

### RAM

The RAM (Randome Access Memory) is volatile.  When the prower supply is lost, the memory stored in RAM is lost.

### ROM

Boot process uses *ROM* (Read-Only Memory).  This is not volatile and doesn't depend on external power supply.

### Flash

Flash memory essentially combines the good parts of both RAM and ROM:
* It is has read/write behavior
* Doesn't depend on external power supply

### Cache

Cache memory (and cache memory architecture) is the set of cheap fast memory that is close to the processor.  The closer to processor, the smaller and faster and more expensive the cache memory is.