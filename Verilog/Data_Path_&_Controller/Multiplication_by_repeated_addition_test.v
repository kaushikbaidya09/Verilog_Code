// Code your testbench
module test_multiplier;
  reg [15:0] data_in;
  reg start, clk;
  wire Done;

  data_path DP (EQ, load_A, load_B, load_P, clear_P, dec_B, clk, data_in);
  control_path CP (load_A, load_B, load_P, clear_P, dec_B, Done,
                   data_in, start, EQ, clk);
  initial
    begin
      clk = 1'b0;
      start = 1'b0;
      #10 start = 1'b1;
    end
  always #5 clk <= ~clk;

  initial 
    begin
      #17 data_in = 7;
      #10 data_in = 16;
    end 

  initial
    begin
      $dumpfile ("multiplier.vcd"); 
      $dumpvars;
      $monitor ($time, "start=%b, done=%b, datain=%d", start, Done, data_in);
      #200 $finish;
    end
endmodule
