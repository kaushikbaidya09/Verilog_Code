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
