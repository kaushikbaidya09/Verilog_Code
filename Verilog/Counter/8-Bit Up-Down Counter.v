/*** Behavioral Up-Down Counter ***/
module counter_u_d (count, clk, rst, u_d, load, data);
    input clk, rst, u_d, load;
    input [7:0]data;
    output [7:0]count;
    reg [7:0]count_temp;

    always@(posedge clk)
        if(!rst)
            count_temp <= 8'd0;
        else if(load)
            count_temp <= data;
        else if(u_d)
            count_temp <= count_temp + 1;
        else 
            count_temp <= count_temp - 1;
    
    assign count = count_temp;
endmodule
