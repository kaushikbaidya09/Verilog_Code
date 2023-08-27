/*** D-flipflop Behavioral 8-bit Twin Register Set ***/
module Reg_set_bh (Q1, Q2, D1, D2, clk, rst);
    input [7:0]D1, D2;
    input clk, rst;
    output reg [7:0]Q1, Q2;

    always@(posedge clk)
        if(rst)
            begin
                Q1 <= 0;
                Q2 <= 0;
            end
        else
            begin
                Q1 <= D1;
                Q2 <= D2;
            end
endmodule
