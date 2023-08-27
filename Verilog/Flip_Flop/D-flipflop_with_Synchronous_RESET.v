/*** D-flipflop Behavioral positive edge triggered
    with Synchronous Active High RESET. ***/
module d_flipflop_bh (q, d, clk, rst);
    input d, clk, rst;
    output reg q;

    always@(posedge clk)
        if(rst)
            q <= 1'b0;
        else
            q <= d;
endmodule

/*** D-flipflop Behavioral negative edge triggered
    with Synchronous Active Low RESET. ***/
module d_flipflop_bh (q, d, clk, rst);
    input d, clk, rst;
    output reg q;

    always@(negedge clk)
        if(!rst)
            q <= 1'b0;
        else
            q <= d;
endmodule
