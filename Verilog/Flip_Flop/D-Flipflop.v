/*** Behavioral D-Flipflop ***/
module d_flipflop_bh (Q,D,Clk);
    input D, Clk;
    output reg Q

    always@(posedge Clk)
        if (clk)  // Can be ignored
            Q <= D;
endmodule
