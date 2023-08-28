/*** UDP 4_to_1 Multiplexer ***/
primitive udp_mux4to1 (f, s0, s1, i0, i1, i2, i3);
    input s0, s1, i0, i1, i2, i3;
    output f;
    table
    //  s0 s1  i0 i1 i2 i3   f
        0  0   0  ?  ?  ?  : 0;
        0  0   1  ?  ?  ?  : 1;
        0  1   ?  0  ?  ?  : 0;
        0  1   ?  1  ?  ?  : 1;
        1  0   ?  ?  0  ?  : 0;
        1  0   ?  ?  1  ?  : 1;
        1  1   ?  ?  ?  0  : 0;
        1  1   ?  ?  ?  1  : 1;
    endtable
endprimitive
