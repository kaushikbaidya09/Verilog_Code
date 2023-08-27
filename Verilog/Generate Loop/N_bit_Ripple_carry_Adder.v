module N_bit_Ripple_adder (sum, c_out, a, b, c_in);
    parameter N = 1;
    input [N-1:0]a,b;
    input c_in;
    output [N-1:0]sum;
    output c_out;
    wire [N:0]carry;

    assign c_out = carry[N];
    assign  carry[0] = c_in;
    
    genvar i;
    generate for(i=0; i<N; i=i+1)
        begin
        FA fa1 (sum[i], carry[i+1], a[i], b[i], carry[i]);
//            wire t1, t2, t3;
//            xor x1 (t1, a[i], b[i]), X2 (sum[i], t1, carry[i]);
//            and a1 (t2, a[i], b[i]), a2 (t3, t1, carry[i]);
//            or r1 (carry[i+1], t2, t3);
        end
    endgenerate
endmodule

module FA (sum, cout, a, b, cin);
    input a, b, cin;
    output sum, cout;
    
    wire t1, t2, t3;
    xor x1 (t1, a, b), X2 (sum, t1, cin);
    and a1 (t2, a, b), a2 (t3, t1, cin);
    or r1 (cout, t2, t3);
endmodule
