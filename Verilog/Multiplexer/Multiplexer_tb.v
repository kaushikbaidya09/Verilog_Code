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
