
module PE_tb (
);

reg clk;
reg rst;

reg [31:0] parent_gene0_input;
reg [31:0] parent_gene1_input;
reg bias = 1;
reg [7:0] co_prob = 8'b01111111;
reg [7:0] perturb_prob = 8'b01111111;
wire [31:0] child_gene_output;

wire [31:0] tie_low;

integer gene_count;

//Block to hint generation of waveforms
initial begin
    $vcdplusfile("PE.vcd");
    $vcdplusmemon();
    $vcdpluson();
end

//Initialize the design
initial begin
    clk = 0;
    rst = 1;
    gene_count = -1;

    #20 rst = 0;
end

//Free running clk
always #5 clk = ~clk;
assign tie_low = 32'b0;

always @(posedge clk)
begin
    if (rst == 1'b1)
    begin
        gene_count = -1;
    end
    else
    begin
        gene_count = gene_count + 1;
    end
end

always @(posedge clk)
begin
    if(rst == 1'b1)
        begin
            parent_gene0_input <= tie_low;
            parent_gene1_input <= tie_low;
        end
    else 
        begin
            if (gene_count == 0)
                begin
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
                end
            else if (gene_count == 1)
                begin
                        // Parent gene 0 initializations
                    parent_gene0_input[7:0] <= 8'b11111111;
                    parent_gene0_input[15:8] <= 8'b00000010;
                    parent_gene0_input[23:16] <= 8'b11111111;
                    parent_gene0_input[31:24] <= 8'b00000100;

                    // Parent gene 1 initializations
                    parent_gene1_input[7:0] <= 8'b00000101;
                    parent_gene1_input[15:8] <= 8'hAA;
                    parent_gene1_input[23:16] <= 8'b00000111;
                    parent_gene1_input[31:24] <= 8'hAA;
                end
            else if (gene_count == 2)
                begin
                        // Parent gene 0 initializations
                    parent_gene0_input[7:0] <= 8'hDD;
                    parent_gene0_input[15:8] <= 8'hCC;
                    parent_gene0_input[23:16] <= 8'hBB;
                    parent_gene0_input[31:24] <= 8'hAA;

                    // Parent gene 1 initializations
                    parent_gene1_input[7:0] <= 8'hDA;
                    parent_gene1_input[15:8] <= 8'hBC;
                    parent_gene1_input[23:16] <= 8'hDA;
                    parent_gene1_input[31:24] <= 8'hBC;
                end
            else 
                begin
                    parent_gene0_input <= tie_low;
                    parent_gene1_input <= tie_low;
                end
    end
end

PE dut(
        .clk(clk),
        .rst(rst),
        .bias(bias),
        .co_prob(co_prob),
        .perturb_prob(perturb_prob),
        .parent_gene0(parent_gene0_input),
        .parent_gene1(parent_gene1_input),
        .child_gene(child_gene_output)
);

always #10000 $finish;
    
endmodule
