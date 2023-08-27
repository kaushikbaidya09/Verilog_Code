/*** Range 10 to 40 Behavioral Up counter ***/
module counter_10to40_up (count, clk, rst);
    input clk, rst;
    output [7:0]count;
    reg [7:0]count_temp;

    always@(posedge clk)
        if(!rst | count_temp <= 8'd9 | count_temp >= 8'd41)
