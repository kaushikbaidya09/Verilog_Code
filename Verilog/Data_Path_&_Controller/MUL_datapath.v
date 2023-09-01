`timescale 1ns / 1ps
module controller (ldA, ldB, ldP, clrP, decB, done, clk, eqz, start);
    input clk, eqz, start;
    output reg ldA, ldB, ldP, clrP, decB, done;
    reg [2:0]state;
    parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
    always@(posedge clk)
        begin
        case (state)
            s0: if (start) state <= s1;
            s1: state <= s2;
            s2: state <= s3;
            s3: if (eqz) state <= s4;
            s4: state <= s4;
        endcase
        end
    always@(state)
        begin
        case (state)
            s0: begin #1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; end
            s1: begin #1 ldA = 1; end
            s2: begin #1 ldA = 0; ldB = 1; clrP = 1; end
            s3: begin #1 ldB = 0; ldP = 1; clrP = 0; decB = 1; end
            s4: begin #1 done = 1; ldB = 0; ldP = 0; decB = 0; end
            default: begin #1 ldA = 0; ldB = 0; ldP = 0; clrP = 0; decB = 0; end
        endcase
        end
endmodule 

module MUL_datapath(eq_Z, ld_A, ld_B, ld_P, clr_P, dec_B, data_in, clk);
    input ld_A, ld_B, ld_P, dec_B, clr_P, clk;
    input [15:0]data_in;
    output eq_Z;
    wire [15:0] x, y, z, Bout, Bus;    
    pipo1 A (x, ld_A, Bus, clk);
    pipo2 P (y, ld_P, clr_P, z, clk);
    add AD (z, x, y);
    control B (Bout, ld_B, dec_B, Bus, clk);
    EQZ comp (eq_Z, Bout);
endmodule

module pipo1 (dout, ld, din, clk);
    input [15:0] din;
    input ld, clk;
    output reg [15:0] dout;    
    always@(posedge clk)
        if(ld) dout <= din;
endmodule

module pipo2 (dout, ld, clr, din, clk);
    input [15:0] din;
    input ld, clr, clk;
    output reg [15:0] dout;    
    always@(posedge clk)
        if (clr) dout <= 16'b0;
        else if (ld) dout <= din;
endmodule

module add (out, in1, in2);
    input [15:0] in1, in2;
    output [15:0] out;    
    assign out = in1 + in2;
endmodule

module control (dout, ld, dec, din, clk);
    input [15:0]din;
    input ld, dec, clk;
    output reg [15:0] dout;    
    always@(posedge clk)
        if (ld) dout <= din;
        else if (dec) dout <= dout - 1;
endmodule

module EQZ (eqz, data);
    input [15:0] data;
    output eqz;    
    assign eqz = (data == 0);
endmodule
