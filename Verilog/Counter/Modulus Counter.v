/*** Modulus counter ***/
module counter_mod47_up (count, clk, rst);
    input clk, rst;
    output [7:0]count;
    reg [7:0]count_temp;

    always@(posedge clk)
        if(!rst | count_temp >= 8'd46) // self correction
            count_temp <= 8'd0;
        else
            count_temp <= count_temp + 1;

    assign count = count_temp;
endmodule
