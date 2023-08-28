/*** UDP D-latch ***/
primitive udp_dlatch (q, d, clk, clr);
    input d, clk, clr;
    output reg d;

    initial 
        q = 0; // optional

    table 
    // d clk clr  q  q_new
        ?  ?  1 : ? : 0;    // clear
        0  1  0 : ? : 0;    // reset
        1  1  0 : ? : 1;    // set
        ?  0  0 : ? : -;    // Memory
    endtable
endprimitive

/*** UDP T Flipflop ***/
primitive udp_t_ff (q, clk, clr);
    input clk, clr;
    output reg q;

    table
    // clk clr  q  q_new
        ?    1 : ? : 0;     // clear
        ?  (10): ? : -;     // 1 to 0 clear falling edge Hold Prev state
      (10)   0 : 0 : 1;     // 1 to 0 clk falling edge Toggle state
      (10)   0 : 1 : 0;     
      (0?)   0 : ? : -;     // 0 to ? clk leading edge Hold prev state
    endtable
endprimitive

/*** UDP negative edge JK-flipflop ***/
primitive udp_jk_ff (q, s, r, clk, clr);
    input s, r, clk, clr;
    output reg q;

    initial
        q = 0; // optional
    
    table
    //  s  r  clk clr  q  q_new
        ?  ?   ?   1 : ? : 0;   // clear
        ?  ?   ? (10): ? : -;
        0  0 (10)  0 : ? : -;
        0  1 (10)  0 : ? : 0;   // reset
        1  0 (10)  0 : ? : 1;   // set
        1  1 (10)  0 : 0 : 1;   // toggle
        1  1 (10)  0 : 1 : 0;
        ?  ? (01)  0 : ? : -;
    endtable
endprimitive
