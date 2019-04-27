//Instance of systolic array
`timescale 1ns/100ps

module perturb_engine(clk, rst, perturb_prob, crossover_gene, child_gene);

input clk;
input rst;
input [31:0] crossover_gene;
input [7:0] perturb_prob;

reg [7:0] seed_wire1 = 8'b00001110;
reg [7:0] seed_wire2 = 8'b00001111;
reg [7:0] seed_wire3 = 8'b11000001;
reg [7:0] seed_wire4 = 8'b11000011;

reg [7:0] mutatedseed_wire1 = 8'b11101100;
reg [7:0] mutatedseed_wire2 = 8'b00101110;
reg [7:0] mutatedseed_wire3 = 8'b11001001;
reg [7:0] mutatedseed_wire4 = 8'b01101001;

wire [7:0] random1_wire;
wire [7:0] random2_wire;
wire [7:0] random3_wire;
wire [7:0] random4_wire;

lfsr randomp1_lfsr (.out(random1_wire), .clk(clk), .rst(rst), .seed(mutatedseed_wire1));
lfsr randomp2_lfsr (.out(random2_wire), .clk(clk), .rst(rst), .seed(mutatedseed_wire2));
lfsr randomp3_lfsr (.out(random3_wire), .clk(clk), .rst(rst), .seed(mutatedseed_wire3));
lfsr randomp4_lfsr (.out(random4_wire), .clk(clk), .rst(rst), .seed(mutatedseed_wire4));

wire select_out1;
wire select_out2;
wire select_out3;
wire select_out4;

output reg [31:0] child_gene;

perturb_selector p1 (.clk(clk), .rst(rst), .perturb_prob(perturb_prob), .seed(seed_wire1), .select(select_out1));
perturb_selector p2 (.clk(clk), .rst(rst), .perturb_prob(perturb_prob), .seed(seed_wire2), .select(select_out2));
perturb_selector p3 (.clk(clk), .rst(rst), .perturb_prob(perturb_prob), .seed(seed_wire3), .select(select_out3));
perturb_selector p4 (.clk(clk), .rst(rst), .perturb_prob(perturb_prob), .seed(seed_wire4), .select(select_out4));

mux m1(.din_0(crossover_gene[7:0]), .din_1(random1_wire), .sel(select_out1), .mux_out(child_gene[7:0]));
mux m2(.din_0(crossover_gene[15:8]), .din_1(random2_wire), .sel(select_out2), .mux_out(child_gene[15:8]));
mux m3(.din_0(crossover_gene[23:16]), .din_1(random3_wire), .sel(select_out3), .mux_out(child_gene[23:16]));
mux m4(.din_0(crossover_gene[31:24]), .din_1(random4_wire), .sel(select_out4), .mux_out(child_gene[31:24]));


always @(posedge clk)
begin
    if(rst==1'b1)
        begin

        end
end

endmodule