
module crossover_selector_tb(
);

reg clk;
reg rst;

reg bias_wire;
reg [3:0] prob_wire;
reg [3:0] random_wire;

wire select_out;

//Block to hint generation of waveforms
initial begin
    $vcdplusfile("crossover_selector.vcd");
    $vcdplusmemon();
    $vcdpluson();
end

//Initialize the design
initial begin
    clk = 0;
    rst = 1;
    bias_wire = 1'b1;
    prob_wire = 4'b0001;
    random_wire = $urandom % 4;

    $write("%h ", bias_wire);
    $write("\n");
    $write("%h ", prob_wire);
    $write("\n");
    $write("%h ", random_wire);

    #10 rst = 0;
end

//Free running clk
always #5 clk = ~clk;

crossover_selector dut(
        .clk(clk),
        .rst(rst),
        .bias(bias_wire),
        .prob(prob_wire),
        .random(random_wire),
        .select(select_out)
);

always #10000 $finish;
    
endmodule
