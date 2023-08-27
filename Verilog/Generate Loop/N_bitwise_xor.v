module N_bit_xor_bitwise (out, a, b);
    parameter N = 32;
    input [N-1:0]a, b;
    output [N-1: 0]out;
    
    genvar p;
    generate for(p=0; p<N; p=p+1)
        begin
            xor xp(out[p], a[p], b[p]);
        end
    endgenerate
endmodule
