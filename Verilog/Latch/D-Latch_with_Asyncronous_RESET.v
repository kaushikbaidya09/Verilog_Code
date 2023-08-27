/*** D-Latch With ASYNC RESET ***/
module D-Latch_bh (Q, D, En, Rst);
    input D, En, Rst;
    output reg Q;

    always@(En, Q, Rst)
        begin
            if(Rst)
                Q = 1'b0;
            else if(En)
                Q = D;
        end
endmodule
