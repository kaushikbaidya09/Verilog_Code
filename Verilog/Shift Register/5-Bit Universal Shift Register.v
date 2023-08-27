/*** 5-bit Behavioral Univarsal shift Register ***/
module USR (PO, SO, PI, sel, clk, rst, SI);
    input [4:0]PI;
    input [1:0]sel;
    input clk, rst, SI;
    output reg [4:0]PO;
    output SO;

    always@(posedge clk)
        if(rst)
            PO <= 0;
        else
            begin
                case (sel)
                    2'b00 : PO <= PO;
                    2'b01 : PO <= {PO[3:0], SI};
                    2'b10 : PO <= {SI, PO[4:1]};
                    2'b11 : PO <= PI;
                    default : PO <= 0;
                endcase
            end

    assign SO = (sel == 2'b01)? PO[4] : PO[0];
endmodule
