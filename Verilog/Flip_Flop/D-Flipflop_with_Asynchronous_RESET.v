/*** D-flipflop behavioural positive edge triggered 
     with Asynchronous Active High Reset. ***/
module D_FF_bh (Q, D, Clk, Rst);
    input D, Clk, Rst;
    output reg Q;

    always@(posedge Clk, posedge Rst)
        begin
            if(Rst)
                Q <= 1'b0;
            else
                D <= Q;
        end
endmodule

/*** D-flipflop behavioural negative edge triggered
     with Asynchronous Active Low Reset. ***/
module d_ff_bh (q, d, clk, rst);
    input d, clk, rst;
    output reg q;

    always@(negedge clk, negedge rst)
        begin
            if(!rst)
                q <= 1'b0;
            else
                q <= d;
        end
endmodule
