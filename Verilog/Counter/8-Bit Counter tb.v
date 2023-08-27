/*** 8-bit Up-counter TESTBENCH ***/
module counter_up_tb;
    reg clk, rst;
    wire [7:0]count;

    counter_up c0 (.clk(clk), .rst(rst), .count(count));

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;

        #10 rst = 0;
        #10 rst = 1;
        #100 $stop;
    end
endmodule
