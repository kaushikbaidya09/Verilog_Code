/*** D-flipflop behavioral positive edge triggered 
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
