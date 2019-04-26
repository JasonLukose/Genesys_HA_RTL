//Instance of systolic array
`timescale 1ns/100ps

module crossover(clk, rst, parent_gene0, parent_gene1, child_gene);

input clk;
input rst;
input [31:0] parent_gene0;
input [31:0] parent_gene1;

reg bias_wire = 1;
reg [3:0] prob_wire = 4'b0111;
reg [3:0] random_wire1 = 4'b1110;
reg [3:0] random_wire2 = 4'b1111;
reg [3:0] random_wire3 = 4'b0001;
reg [3:0] random_wire4 = 4'b0011;

wire select_out1;
wire select_out2;
wire select_out3;
wire select_out4;

output reg [31:0] child_gene;

crossover_selector c1 (.clk(clk), .rst(rst), .bias(bias_wire), .prob(prob_wire), .random(random_wire1), .select(select_out1));
//crossover_selector c2 (.clk(clk), .rst(rst), .bias(bias_wire), .prob(prob_wire), .random(random_wire2), .select(select_out2));
//crossover_selector c3 (.clk(clk), .rst(rst), .bias(bias_wire), .prob(prob_wire), .random(random_wire3), .select(select_out3));
//crossover_selector c4 (.clk(clk), .rst(rst), .bias(bias_wire), .prob(prob_wire), .random(random_wire4), .select(select_out4));

mux m1(.din_0(parent_gene0[7:0]), .din_1(parent_gene1[7:0]), .sel(select_out1), .mux_out(child_gene[7:0]));


always @(posedge clk)
begin
    if(rst==1'b1)
        begin
            
        end
end

endmodule