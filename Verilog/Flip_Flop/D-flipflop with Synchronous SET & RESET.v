/*** D-flipflop Behavioral positive edge triggered with 
    Synchronous Active Low RESET & Active High SET. ***/
module d_ff_bh (q, d, clk, rst, set);
    input d, clk, rst, set;
    output reg q;

    always@(posedge clk)
        if(!rst)
            q <= 1'b0;
        else if(set)
            q <= 1'b1;
        else
            q <= d;
endmodule
