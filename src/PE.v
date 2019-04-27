//Instance of systolic array
`timescale 1ns/100ps

module PE(clk, rst, bias, co_prob, perturb_prob, parent_gene0, parent_gene1, child_gene);

input clk;
input rst;
input bias;
input [7:0] co_prob;
input [7:0] perturb_prob;
input [31:0] parent_gene0;
input [31:0] parent_gene1;

reg [31:0] temp_latch;

output reg [31:0] child_gene;
wire [31:0] crossover_gene;

crossover_engine c_engine (.clk(clk), .rst(rst), .bias(bias), .co_prob(co_prob), .parent_gene0(parent_gene0), .parent_gene1(parent_gene1), .crossover_gene(crossover_gene));
perturb_engine p_engine (.clk(clk), .rst(rst), .perturb_prob(perturb_prob), .crossover_gene(temp_latch), .child_gene(child_gene));


always @(posedge clk)
begin
    if(rst == 1'b0)
        begin
            temp_latch = crossover_gene;
        end
end


endmodule