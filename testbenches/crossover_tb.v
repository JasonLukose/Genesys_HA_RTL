
module crossover_tb (
);

reg clk;
reg rst;

reg [31:0] parent_gene0_input;
reg [31:0] parent_gene1_input;
wire [31:0] child_gene_output;

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

    // Parent gene 1 initializations
    parent_gene1_input[7:0] <= 8'b00000101;

    $write("%h ", parent_gene0_input);
    $write("\n");
    $write("%h ", parent_gene1_input);


    #20 rst = 0;
end

//Free running clk
always #5 clk = ~clk;

crossover dut(
        .clk(clk),
        .rst(rst),
        .parent_gene0 (parent_gene0_input),
        .parent_gene1 (parent_gene1_input),
        .child_gene (child_gene_output)
);

always #10000 $finish;
    
endmodule
