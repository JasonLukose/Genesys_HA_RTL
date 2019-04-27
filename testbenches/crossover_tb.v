
module crossover_tb (
);

reg clk;
reg rst;

reg [31:0] parent_gene0_input;
reg [31:0] parent_gene1_input;
wire [31:0] crossover_gene_output;

//Block to hint generation of waveforms
initial begin
    $vcdplusfile("crossover.vcd");
    $vcdplusmemon();
    $vcdpluson();
end

//Initialize the design
initial begin
    clk = 0;
    rst = 1;
    // Parent gene 0 initializations
    parent_gene0_input[7:0] <= 8'b00000001;
    parent_gene0_input[15:8] <= 8'b00000010;
    parent_gene0_input[23:16] <= 8'b00000011;
    parent_gene0_input[31:24] <= 8'b00000100;

    // Parent gene 1 initializations
    parent_gene1_input[7:0] <= 8'b00000101;
    parent_gene1_input[15:8] <= 8'b00000110;
    parent_gene1_input[23:16] <= 8'b00000111;
    parent_gene1_input[31:24] <= 8'b00001000;

    $write("%h ", parent_gene0_input);
    $write("\n");
    $write("%h ", parent_gene1_input);


    #20 rst = 0;
end

//Free running clk
always #5 clk = ~clk;

crossover_engine dut(
        .clk(clk),
        .rst(rst),
        .parent_gene0 (parent_gene0_input),
        .parent_gene1 (parent_gene1_input),
        .crossover_gene (crossover_gene_output)
);

always #10000 $finish;
    
endmodule
