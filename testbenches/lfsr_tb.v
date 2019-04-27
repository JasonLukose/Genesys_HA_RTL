module lfsr_tb();
reg clk_tb;
reg rst_tb;
reg [7:0] seed_tb;
wire [7:0] out_tb;

//Block to hint generation of waveforms
initial begin
    $vcdplusfile("lfsr.vcd");
    $vcdplusmemon();
    $vcdpluson();
end

initial
begin
    clk_tb = 0;
    seed_tb = 8'b00000101;
    rst_tb = 1;
    #15;
    
    rst_tb = 0;
    #200;
end

always
begin
    #5;
    clk_tb = ~ clk_tb;
end

lfsr DUT(out_tb,clk_tb,rst_tb,seed_tb);

always #10000 $finish;


endmodule