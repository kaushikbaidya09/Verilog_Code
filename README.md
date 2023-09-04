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
       - For Sequential execution of statement `begin ... end ` blocks are used.
       - For Parallel execution of statements `fork ... join ` blocks are used.
   * Non-Blocking ( <= ) 
       - Non-blocking assignments execute concurrently.
       - Assignments to the target scheduled at the end of the simulation cycle.
- Structured Procedures
   * Initial and Always blocks
     Functions | Task
      -- | -- 
     Only Combinational | both Combinational and sequential
     1 to inf inputs and only 1 output | 0 to inf input, output, inouts
     Functions cannot have Delays | Task can have Delays
     One function can call another function but cannot call task | One task can call both function and task

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
- Only one scalar output must be used and combinational output declared as "output" & sequential output declared as "reg".
- "?" don't care cannot be used in the output field.
- "-" specifies no change condition only in the output field.
- (01) or "r" represents Rising edge.
- (10) or "f" represents the Falling edge.
- "*" indicates any value change in the signal.

# Modeling Finite State Machines

- Combinational and Sequential Circuits
    * In combinational circuit Output depends only on the inputs applied and not on previous input.
    * In Sequential circuits the output depends on the applied inputs and also on the internal state.
- The internal states change with time and states should be finite hence sequential circuits are also referred to as Finite State Machine (FSM).
- FSM can be represented either in a `state table` or in the form of a `state transition diagram`.

## Mealy and More State Machine

- Moore State Machine
    * Output is the function of the present state only.
- Mealy State Machine
    * Output is the function of the present state as well as the inputs.

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
- `$dumpon;` Start dumping variable that was previously stopped.
- `$dumpvars (level, list of variables or modules);`
    * `level = 0` All variables within the module will be dumped.
    * `level = 1` only listed variables will be dumped.
- `$dumpall;` current values of all variables will be written to the file.
- `$dumplimit (filesize);` set maximum .vcd file size.

# Data Path and Controller Design
- Data Path contains functional units where all computations are carried out.
   * registers, multiplexers, bus, adders, multipliers, counters and other functional blocks.
- Control Path implements a finite state machine and provides control signals to the data path in proper sequence.
- In response to control signals various operations are carried out by data path.
