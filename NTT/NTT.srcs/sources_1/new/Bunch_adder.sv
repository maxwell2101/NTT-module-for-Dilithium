`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2025 02:01:31 AM
// Design Name: 
// Module Name: Adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bunch_adder(
  input clk,
  input enable,
  input [7:0] a [0:3][0:1],
  input [7:0] b [0:3][0:1],
  output reg [8:0] sum [0:3]
    );
    wire [8:0] tmp [0:3][0:1];
    genvar i, j;
    generate
      for(i = 0; i < 4; i = i + 1) begin
        for(j = 0; j < 2; j = j + 1) begin
          Adder adder0(.clk(clk), .enable(enable), .a(a[i][j]), .b(b[i][j]), .sum(tmp[i][j]));
          Adder adder1(.clk(clk), .enable(enable), .a(sum[i]), .b(tmp[i][j]), .sum(sum[i]));
        end
      end
    endgenerate
    always @(posedge clk) begin
      if(enable == 0) sum = '{{0},{0},{0},{0}};
        
    end
endmodule
