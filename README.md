# Verilog_Code

## Contents
- [Procedural Assignment](#Procedural-Assignment)
- [User-Define Primitives](#User-Defined-Primitives-(UDP))
- [Modeling Finite State Machines](#Modeling-Finite-State-Machines)
- [Verilog Testbench](#Verilog-Testbench)
- [Combinational Circuit](#combinational-circuit)
    * [Multiplexer](#multiplexer)


## Procedural Assignment
- Procedural Assignment statement update variables of type "reg", "integer", "real" or "time", here "Net" type variables are not used.  
- The value assigned to the variable remains unchanged until another procedural assignment statement assigns a new value to the variable.
* Blocking ( = )
    - Blocking assignments execute step by step sequentially.
    - Blocking assignments do not block statements in other always blocks but the order of execution may change according to simulation. 
* Non-Blocking ( <= ) 
    - Non-blocking assignments execute concurrently.
    - Assignments to the target scheduled at the end of the simulation cycle.

## User-Defined Primitives (UDP)
- Used to define custom Verilog primitives by the use of lookup tables.
    * Truth table for combinational functions.
    * State table for sequential function.
    * Don't care, rising and falling edge etc., can be specified in the lookup table.
- For combinational functions, the Truth Table specified as  
    `<input_1> <input_2> ... <input_N> : <output>;`
- For sequential functions State table is specified as  
`<input_1> <input_2> ... <input_N> : <present_state> : <next_state>;`

### Rules & Guidelines to Define a User Define Primitives
- Input terminals of UDP can only be a scalar, and cannot be a Vector.
- Only one scalar output must be used. For combinational output declared as "output" & for sequential output declared as "reg".
- "?" don't care cannot be used in the output field.
- "-" specifies no change condition only in the output field.
- (01) or "r" represents Rising edge.
- (10) or "f" represents the Falling edge.
- "*" indicates any value change in the signal.

# Modeling Finite State Machines

- Combinational and Sequential Circuits
    * In combinational circuit Output depends only on the inputs applied and not on previous inputs.
    * In Sequential circuits the output depends on the applied inputs and also on the internal state.
- The internal states change with time and states should be finite hence sequential circuits are also referred to as Finite State Machine (FSM).
- FSM can be represented either in a `state table` or in the form of a `state transition diagram`.

## Mealy and More State Machine

- Moore State Machine
    * Output is the function of the present state only.
- Mealy State Machine
    * Output is the function of the present state as well as the inputs.

### Examples of Moore Machine
---
### Example 1
The traffic light with three lamps states RED, GREEN, & YELLOW and inputs are null, a transition occurs with the clock signals.
#### Verilog code
```Verilog
/***
Moore State Machine with cyclic light
    S0 -> RED
    S1 -> GREEN
    S2 -> YELLOW            ***/
module cyclic_lamp (clock, light);
    input clock;
    output reg [0:2] light;
    parameter s0=0, s1=1, s2=2;
    parameter RED=3'b100, GREEN=3'b010, YELLOW=3'b001;
    reg [0:1] state;

    always@(posedge clock)
        case (state)
            s0: state <= s1;
            s1: state <= s2;
            s2: state <= s0;
            default: state <= s0;
        endcase

    always@(state)
        case (state)
            s0: light = RED;
            s1: light = GREEN;
            s2: light = YELLOW;
            default: light = RED;
        endcase
endmodule
```
#### Testbench
```verilog
module test_cyclic_lamp;
    reg clk;
    wire [0:2] light;
    cyclic_lamp LAMP (.clock(clk), .light(light));

    always #5 clk = ~clk;

    initial 
        begin
        clk = 1'b0;
        #100 $finish;
        end
    
    initial 
        begin
        $dumpfile ("cyclic.vcd");
        $dupvars(0, test_cyclic_lamp);
        $monitor ($time, "RGY: %b", light);
        end
endmodule
```

#### Example 2
---
Serial Parity Detector, stream of bits fed in synchronism with the clock. 0 indicates "EVEN number of 1's seen so far" and 1 indicates "ODD number of 1's seen so far".
#### Verilog code
```Verilog
module parity (out, clk, in);
    input in, clk;
    output reg out;
    reg even_odd;   // The Machine State
    parameter EVEN=0; ODD=1;

    always@(posedge clk)
        case (even_odd)
            EVEN: even_odd <= in ? ODD : EVEN;
            ODD: even_odd <= in ? EVEN : ODD;
            default: even_odd <= EVEN;
        endcase

    always@(even_odd)
        case (even_odd)
            EVEN: out = 0;
            ODD: out = 1;
        endcase
endmodule
```
### Example of Mealy Machine
```verilog
/*** Sequence detector for pattern "0110" ***/
module seq_detector (x, clk, reset, z);
    input x, clk, reset;
    output reg z;
    parameter s0=0, s1=1, s2=2, s3=3;
    reg [0:1] PS, NS;

    always@(posedge clk, posedge reset)
        if (reset) PS <= s0;
        else PS <= NS;

    always@(PS, x)
        case (PS)
            s0: begin
                z = x ? 0 : 0;
                NS = x ? s0 : s1; end
            s1: begin
                z = x ? 0 : 0;
                NS = x ? s2 : s1; end
            s2: begin
                z = x ? 0 : 0;
                NS = x ? s3 : s1; end
            s3: begin
                z = x ? 0 : 1;
                NS = x ? s0 : s1; end
        endcase
endmodule
```
```Verilog 
/*** Sequence detector testbench ***/
module test_sequence;
    reg clk, x, reset;
    wire z;

    seq_detector SEQ (x, clk, reset, z);

    initial 
        begin
        $dumpfile("sequence.vcd");
        $dumpvars(0, test_sequence);
        clk = 1'b0;
        reset = 1'b1;
        #15 reset = 1'b0;
        end

    always #5 clk = ~clk;

    initial 
        begin
        #12 x=0; #10 x=0; #10 x=1; #10 x=1;
        #10 x=0; #10 x=1; #10 x=1; #10 x=0;
        #10 x=0; #10 x=1; #10 x=1; #10 x=0;
        #10 $finish;
        end
endmodule
```

# Verilog Testbench

- Inputs and Outputs of DUT are connected to the testbench
- Inputs are declared as `reg` & Output are `declared` as wire.
- `initial block` runs only once ( used only in testbench)
- `always block` run multiple times.

### Simulation Directives

- `$display ("<format>", expr1, expr2, ... );` Print text and values to stdout.
- `$monitor ("<format>", var1, var2, ... );` Print this format when there is a change in the variable.
- `$finish` Terminate the simulation process.
- `$dumpfile (<filename>);` .vcd (value change dump) file extension
- `$dumpoff;` Stops dumping variables.
- `$dumpon;` Start dumping variable that was previously stoped.
- `$dumpvars (level, list of variables or modules);`
    * `level = 0` All variables within the module will be dumped.
    * `level = 1` only listed variables will be dumped.
- `$dumpall;` current values of all variables will be written to the file.
- `$dumplimit (filesize);` set maximum .vcd file size.

### Example 1: Full Adder Testbench
#### Type 1
```Verilog
module testbench_FA;
    reg a, b, c;
    wire sum, cout;
    full_adder FA (sum, cout, a, b, c);

    initial
        begin
            $monitor ($time, " a=%b, b=%b, c=%b, sum=%b, 
                        cout=%b", a, b, c, sum, cout);
            #5 a=0; b=0; c=1;
            #5 b=1;
            #5 a=1;
            #5 a=0; b=0; c=0;
            #5 $finish;
        end
endmodule
```
#### Type 2
```Verilog
module testbench;
    reg a, b, c;
    wire sum, cout;
    full_adder FA (sum, cout, a, b, c);

    initial
        begin
            a=0; b=0; c=1; #5;
            $display ("T=%2d, a=%b, b=%b, c=%b, sum=%b, cout=%b", $time, a, b, c, sum, cout);
            b=1; #5;
            $display ("T=%2d, a=%b, b=%b, c=%b, sum=%b, cout=%b", $time, a, b, c, sum, cout);
            a=1; #5;
            $display ("T=%2d, a=%b, b=%b, c=%b, sum=%b, cout=%b", $time, a, b, c, sum, cout);
            a=0; b=0; c=0; #5;
            $display ("T=%2d, a=%b, b=%b, c=%b, sum=%b, cout=%b", $time, a, b, c, sum, cout);
            #5 $finish;
        end
endmodule
```
#### Type 3
```Verilog
module testbench;
    reg a, b, c;
    wire sum, cout;
    integer i;
    full_adder FA (sum, cout, a, b, c);

    initial 
        begin
            $dumpfile("full_adder.vcd");
            $dumpvars(0, testbench);
            for (i=0; i<8; i=i+1)
                begin
                    {a, b, c} = i; #5;
                    $display ("T=%2d, a=%b, b=%b, c=%b, sum=%b, cout=%b", $time, a, b, c, sum, cout);
                end
            #5 $finish;
        end
endmodule
```

## Combinational Circuit
### Multiplexer

Breaking down 16:1 MUX from behavioral to structural behavioral logic

```Verilog
/*** MULTIPLEXER 16 to 1 ***/
`timescale 1ns / 1ps

/* Behavioral Module (MUX 2to1) */
module mux_2to1(in, sel, out);
    input [1:0]in;
    input sel;
    output out;

    assign out = in[sel];
endmodule

/* Structural Module (MUX 4to1 from 2to1) */
module mux_4to1(in, sel, out);
    input [3:0]in;
    input [1:0]sel;
    output out;
    wire [1:0]t;
    
    mux_2to1 m0 (in[1:0], sel[0], t[0]);
    mux_2to1 m2 (in[3:2], sel[0], t[1]);
    mux_2to1 m3 (t, sel[1], out);
endmodule

/* Structural Module (MUX 16to1 from 4to1) */
module mux_16to1(in, sel, out);
    input [15:0]in;
    input [3:0]sel;
    output out;
    wire [3:0]t;
    
    mux_4to1 m0 (in[3:0], sel[1:0], t[0]);
    mux_4to1 m1 (in[7:4], sel[1:0], t[1]);
    mux_4to1 m2 (in[11:8], sel[1:0], t[2]);
    mux_4to1 m3 (in[15:12], sel[1:0], t[3]);
    mux_4to1 m4 (t, sel[3:2], out);
endmodule
```
### Testbench
```Verilog
/*** Verilog Testbench : MULTIPLEXER 16 to 1 ***/
`timescale 1ns / 1ps

module muxtest;
  reg [15:0]A;
  reg [3:0]S;
  wire F;
  
  mux_16to1 M (.in(A), .sel(S), .out(F));
  
  initial
    begin
      $dumpfile("mux16to1.vcd");
      $dumpvars(0, muxtest);
      $monitor($time, "A=%h, S=%h, F=%b", A,S,F);
      #5 A=16'haaaa; S=4'h0;
      #5 S=4'h2;
      #5 S=4'h3;
      #5 S=4'h5;
      #5 $finish;
    end
endmodule
```
