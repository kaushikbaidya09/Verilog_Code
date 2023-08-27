/*** Parametarized N-Bit Counter ***/
module N_bit_counter (clear, clock, count);
    parameter N = 7;
    input clear, clock;
    output [0:N]count;

    always@(posedge clock)
        if(clear)   count <= 0;
        else        count <= count + 1;
endmodule
