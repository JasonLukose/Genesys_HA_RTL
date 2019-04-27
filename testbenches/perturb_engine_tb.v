
module perturb_engine_tb (
);

reg clk;
reg rst;

reg [31:0] crossover_gene_input;
wire [31:0] child_gene_output;

//Block to hint generation of waveforms
initial begin
    $vcdplusfile("perturbation.vcd");
    $vcdplusmemon();
    $vcdpluson();
end

//Initialize the design
initial begin
    clk = 0;
    rst = 1;
    // CrossOverGene initializations
    crossover_gene_input[7:0] <= 8'b00000001;
    crossover_gene_input[15:8] <= 8'b00000010;
    crossover_gene_input[23:16] <= 8'b00000011;
    crossover_gene_input[31:24] <= 8'b00000100;

    #20 rst = 0;
end

//Free running clk
always #5 clk = ~clk;

perturb_engine dut(
        .clk(clk),
        .rst(rst),
        .crossover_gene (crossover_gene_input),
        .child_gene (child_gene_output)
);

always #10000 $finish;
    
endmodule
