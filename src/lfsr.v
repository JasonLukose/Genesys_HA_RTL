//Instance of systolic array
`timescale 1ns/100ps
module lfsr (out, clk, rst, seed);

  output reg [7:0] out;
  input clk, rst;
  input [7:0] seed;

  wire feedback;

  assign feedback = out[7] ^ ~out[6] ^ ~out[5] ^ ~out[4];

always @(posedge clk, posedge rst)
  begin
    if (rst)
      out = seed;
    else
      out = {out[6:0],feedback};
  end
endmodule