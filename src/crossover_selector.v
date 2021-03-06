//Instance of systolic array
`timescale 1ns/100ps

module crossover_selector(clk, rst, bias, prob, seed, select);

input clk;
input rst;
input [0:0] bias;
input [7:0] prob;
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
        if (prob > random) 
        begin
            select <= 1 ^ bias;
        end
        else begin
            select <= 0 ^ bias;
        end
    end
end

endmodule