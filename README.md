# Verilog Learning
Started 04/17/2025

How to run verilog file: "iverilog -o main.vvp main.v," where main.v is the file with Verilog code, main.vvp is executable file

## Difference between reg and wire
A *wire* represents a physical connection between different elements in a circuit. It is used to connect inputs and outputs of various modules and can be driven by continious assignments. Wires do not store values; they simply propagate signals.

*reg" represents a "data storage element" that retains/keeps its value until a new value is assigned. It is used in procedural blocks like "always" or "initial" blocks.
## Sensitivity list

List of variables in parentheses after "__always @__" is sensitivity list
They indicate which signals can contribute to changes inside the block.

*posedge* defines the flop as rising-edge triggered (*negedge* would be falling-edge triggered).

At every rising clock edge (*and only at a rising clock edge*), the value of "in_1" is assigned to "out_1."

```
always @ (posedge clk)
    begin
        out_1 <= in_1;
    end
```

## Difference between "=" and "<="
"=" is a *blocking* assignment. It executes *immediately* (blocks next line until done)

"<=" is a *non-blocking* assignment. It executes *later*, allows next line to run immediately (multiple assignments with <= execute at the same time using original values)

Verilog used a specific format for statis values, like 1'b0. The first field defines the number of bits (the width of the vector), the next field, separated by the apostrophe, defines the radix (counting base), and the last field defines the actual value.

## Use of "assign"
The keyword "assign" is used to make *continious assignments* to *net variables* (usually *wire* types). It's part of the dataflow modeling style, where you describe how data flows between elements rather than how it's processed step-by-step.

For example
```
wire a, b, c;
assign c = a & b; // c will always be the result of a AND b
```

## Types of logic

### 1. Structural Logic
This is like building with Lego blocks - you instantiate and connect components (like gates, modules, flip-flops) explicitly. It is used when modeling exact gate-level behavior or designing using pre-built modules.

```
and (S, D, EN);
not (D_not, D);
and (R, D_not, EN);
nand (Qnot, S, Q);
nand (Q, R, Qnot);

```

### 2. Behavioral/Procedural Logic
This describes how the circuit should behave, not how it's built. It uses constructs like __always__, __if__, __case__, etc. It is used for finite state machines, registers, counters, etc.

```
always @(*) begin
    if (EN)
        Q = D;
end
```

### 3. Dataflow Logic
You use __assign__ statements and logic expressions to describe how data flows between signals.

```
assign Q = EN ? D : Q;
```

### 4. Register-Transfer Level (RTL) Logic
RTL is a __design abstraction__ that includes both __data movement between registers__ and the __logic__ that processes it. It combines both __procedural__ and __dataflow__ styles.

```
always @(posedge clk) begin
    if (reset)
        Q <= 0;
    else if (EN)
        Q <= D;
end
```

## Module Instantiation (Using one module inside of another)
Let's say you have the following module __and_gate__
```
module and_gate (
    input wire a,
    input wire b,
    output wire y
);
    assign y = a & b;
endmodule
```

You can __instantiate__ it in another module
```
module top_module (
    input wire in1,
    input wire in2,
    output wire out1
);

    // Instantiation of and_gate
    and_gate u1 (           // u1 is an instance name
        .a(in1),            // connect in1 to a
        .b(in2),            // connect in2 to b
        .y(out1)            // connect output y to out1
    );

endmodule
```

Shorthand ```and_gate u1 (in1, in2, out1);```

### General Synatx of Module Instantiation
```
<module_name> <instance_name> (
    .<port_name>(<signal_name>),
    .<port_name>(<signale_name>),
    ...
);
```

### Files Inclusion
To include one file inside of another to, for example, instantiate a module use the following line: `include "adder.v"`

## __wire__ vs __reg__

Use __wire__ when:
1. You're connecting __combinational logic__.
2. You're connecting __continious assignments__ with the __assign__ keyword.
3. You're __connecting module ports__(inputs/outputs).

`assign Y = A & B; // OK because Y is a wire`

Can't be used:
1. Inside __always__ blocks for assignments.
2. To hold a value - wire don't __store__, they just __connect__.

Use __reg__ when:
1. You're assigning values *inside* an __always__ block.
2. You need the variable to __hold state__ (like a memory cell or latch)
3. You're modeling __sequential logic__ (flip-flops, clocks, etc.)

Inside an __always__ block, you can only assign values to variables declared as __reg__.

__*Shorthand*__:\
__assign__ -> use with __wire__\
__always__ -> assign to __reg__

```
reg Y;
always @(*) begin
    if (A)
        Y = B;
end
```

## Combinational vs. Sequential Logic

### Combinational Logic:
1. Output depends only on __current__ inputs.
2. No memory - it doesn't "remember" previous values.
3. Examples: adders, multiplexers, encoders, decoders, basic gates.

Behavior:
If inputs change, outputs change __immediately__ (as soon as gates propagate)
`assign Y = A & B; // Combinational - output Y changes as soon as A or B changes`

### Sequential Logic:
1. Output depends on __current inputs AND past inputs__ (i.e., state).
2. Has memory - uses flip-flops, latches, or registers to store data.
3. Examples: counters, shift registers, state machines (FSMs), RAMs.

Behavior:
State changes __only at clock edges__, and output reflects those stored values.
```
always @(posedge CLK)
    Q <= D;  // Sequential — stores D into Q on rising edge of the clock
```

