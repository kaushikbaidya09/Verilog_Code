/*** DATA FLOW MODEL ***/
module d_latch (Q, D, En);
    input D, En;
    output Q;

    assign Q = En ? D : Q;
endmodule

/*** BEHAVIORAL MODEL ***/
module d_latch_bh (Q, D, En);
    input D, En;
    output reg Q;

    always@(En, Q)
        if(En) Q = D;
endmodule
