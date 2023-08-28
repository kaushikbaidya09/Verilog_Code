/*** UDP 4-Input AND function ***/
primitive udp_and4 (f, a, b, c, d);
    input a, b, c, d;
    output f;
    table
    //  a b c d   f
        0 ? ? ? : 0;
        ? 0 ? ? : 0;
        ? ? 0 ? : 0;
        ? ? ? 0 : 0;
        1 1 1 1 : 1;
    endtable
endprimitive

/*** UDP 4-Input OR function ***/
primitive udp_or4 (f, a, b, c, d);
    input a, b, c, d;
    output f;
    table
    //  a b c d   f
        1 ? ? ? : 1;
        ? 1 ? ? : 1;
        ? ? 1 ? : 1;
        ? ? ? 1 : 1;
        0 0 0 0 : 0;
    endtable
endprimitive
