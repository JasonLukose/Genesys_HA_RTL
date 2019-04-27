//Instance of systolic array
`timescale 1ns/100ps

module crossover_engine(clk, rst, bias, co_prob, parent_gene0, parent_gene1, crossover_gene);

input clk;
input rst;
input [31:0] parent_gene0;
input [31:0] parent_gene1;
input bias;
input [7:0] co_prob;

reg [7:0] seed_wire1 = 8'b00001110;
reg [7:0] seed_wire2 = 8'b00001111;
reg [7:0] seed_wire3 = 8'b11000001;
reg [7:0] seed_wire4 = 8'b11000011;

wire select_out1;
wire select_out2;
wire select_out3;
wire select_out4;

output reg [31:0] crossover_gene;

crossover_selector c1 (.clk(clk), .rst(rst), .bias(bias), .prob(co_prob), .seed(seed_wire1), .select(select_out1));
crossover_selector c2 (.clk(clk), .rst(rst), .bias(bias), .prob(co_prob), .seed(seed_wire2), .select(select_out2));
crossover_selector c3 (.clk(clk), .rst(rst), .bias(bias), .prob(co_prob), .seed(seed_wire3), .select(select_out3));
crossover_selector c4 (.clk(clk), .rst(rst), .bias(bias), .prob(co_prob), .seed(seed_wire4), .select(select_out4));

mux m1(.din_0(parent_gene0[7:0]), .din_1(parent_gene1[7:0]), .sel(select_out1), .mux_out(crossover_gene[7:0]));
mux m2(.din_0(parent_gene0[15:8]), .din_1(parent_gene1[15:8]), .sel(select_out2), .mux_out(crossover_gene[15:8]));
mux m3(.din_0(parent_gene0[23:16]), .din_1(parent_gene1[23:16]), .sel(select_out3), .mux_out(crossover_gene[23:16]));
mux m4(.din_0(parent_gene0[31:24]), .din_1(parent_gene1[31:24]), .sel(select_out4), .mux_out(crossover_gene[31:24]));


always @(posedge clk)
begin
    if(rst==1'b1)
        begin
            
        end
end

endmodule