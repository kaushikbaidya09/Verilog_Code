/*** Full Adder sum generated using UDP ***/
primitive udp_sum (sum, a, b, c);
    input a, b, c;
    output sum;
    table
    // a b c  sum
       0 0 0 : 0;
       0 0 1 : 1;
       0 1 0 : 1;
       0 1 1 : 0;
       1 0 0 : 1;
       1 0 1 : 0;
       1 1 0 : 0;
       1 1 1 : 1;
    endtable
endprimitive

/*** Full Adder Carry generated using UDP ***/
primitive udp_carry (cout, a, b, c);
    input a, b, c;
    output cout;
    table
    //  a b c  cout
        0 0 ? : 0;
        0 ? 0 : 0;
        ? 0 0 : 0;
        1 1 ? : 1;
        1 ? 1 : 1;
        ? 1 1 : 1;
    endtable
endprimitive
/*** Instantiating UDP's FULL ADDER ***/
module full_adder (sum, cout, a, b, c);
    input a, b, c;
    output sum, cout;

    udp_sum SUM (sum, a, b, c);
    udp_carry CARRY (cout, a, b, c);
endmodule
