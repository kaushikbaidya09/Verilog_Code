/*** 5-bit Left to Right Shift Register ***/
module SR_LR (SO, clk, rst, SI);
    input SI, clk, rst;
    output SO;
    reg [4:0]SR;

    always@(posedge clk, negedge rst)
            if(!rst)
                SR <= 5'd0;
            else
                SR <= {SI, SR[4:1]};
    
    assign SO = SR[0];
endmodule

/*** 5-bit Right to Left Shift Register ***/
module SR_RL (SO, clk, rst, SI);
    input SI, clk, rst;
    output SO;
    reg [4:0]SR;

    always@(posedge clk, negedge rst)
        if(!rst)
            SR <= 5'd0;
        else
            SR <= {SR[3:0], SI};
    
    assign SO = SR[4];
endmodule
