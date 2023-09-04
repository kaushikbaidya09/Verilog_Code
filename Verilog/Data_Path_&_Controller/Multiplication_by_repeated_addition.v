/*** CONTROL PATH MODULE with STATE MACHINE ***/
module control_path (load_A, load_B, load_P, clear_P, dec_B, Done,
                     data_in, start, EQ, clk);
  input [15:0] data_in;
  input start, EQ, clk;
  output reg load_A, load_B, load_P, clear_P, dec_B, Done;
  reg [2:0] state;
  parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;
  always@(posedge clk)
    case (state)
      s0: if (start) state <= s1;
      s1: state <= s2;
      s2: state <= s3;
      s3: #2 if (EQ) state <= s4;
      s4: state <= s4;
      default: state <= s0;
    endcase
  always@(state)
    case (state)
      s0: begin #1 load_A=0; load_B=0; load_P=0; clear_P=0; dec_B=0; Done=0; end
      s1: begin #1 load_A=1; end
      s2: begin #1 load_A=0; load_B=1; clear_P=1; end
      s3: begin #1 load_B=0; clear_P=0; load_P=1; dec_B=1; end
      s4: begin #1 Done=1; end
      default: begin load_A=0; load_B=0; load_P=0; clear_P=0; dec_B=0; Done=0; end
    endcase
endmodule

////////////////////////////////////////////////////////////////////////////////////////////
/*** DATA PATH MODULE ***/
module data_path (EQ, 
                  load_A, load_B, load_P, clear_P, dec_B, clk, Bus);
  input load_A, load_B, load_P, clear_P, dec_B, clk;
  input [15:0] Bus;
  output EQ;
  reg [15:0] Aout, Bout, Pout;
  wire [15:0] Z;
  pipo1 A (Aout, Bus, load_A, clk);
  pipo2 p (Pout, Z, load_P, clear_P, clk);
  count B (Bout, Bus, load_B, dec_B, clk);
  adder ADD (Z, Aout, Pout);
  compare COMP (EQ, Bout);
endmodule

/*** PIPO1 Module  parallel in parallel out ***/
module pipo1 (d_out, Bus, load, clk);
  input [15:0] Bus;
  input load, clk;
  output reg [15:0] d_out;
  always@(posedge clk)
    begin
      if (load == 1'b1) d_out <= Bus;
    end
endmodule

/*** PIPO2 Module ***/
module pipo2 (d_out, Z, load, clear, clk);
  input [15:0] Z;
  input load, clear, clk;
  output reg [15:0] d_out;
  always@(posedge clk)
    begin
      if (load == 1'b1) d_out <= Z;
      else if (clear == 1'b1) d_out <= 0; 
      else d_out <= d_out;
    end
endmodule

/*** COUUNT B Module ***/
module count (Bout, Bus, load, dec, clk);
  input [15:0] Bus;
  input load, dec, clk;
  output reg [15:0] Bout;
  always@(posedge clk)
    begin
      if (load == 1'b1) Bout <= Bus;
      else if (dec == 1'b1) Bout <= (Bout - 1);
    end
endmodule

/*** ADDER Module ***/
module adder (add_out, in1, in2);
  input [15:0] in1, in2;
  output reg [15:0] add_out;
  always@(*)
    add_out = (in1 + in2);
endmodule

/*** COMPARE Module ***/
module compare (eq, data);
  input [15:0] data;
  output eq;
  assign eq = (~|data) ? 1'b1 : 1'b0;
endmodule
