//Instance of systolic array
`timescale 1ns/100ps

module perturb_selector(clk, rst, perturb_prob, seed, select);

input clk;
input rst;
input [7:0] perturb_prob;
input [7:0] seed;

wire [7:0] random;

lfsr random_lfsr (.out(random), .clk(clk), .rst(rst), .seed(seed));

output reg select;

always @(posedge clk)
begin
    if(rst==1'b1)
        begin
            select <= 1'b0;
        end
    else 
    begin
        if (perturb_prob > random) 
        begin
            select <= 1;
        end
        else begin
            select <= 0;
        end
    end
end

endmodule