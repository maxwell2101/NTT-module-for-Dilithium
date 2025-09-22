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


module Adder(
  input clk,
  input enable,
  input [7:0] a,
  input [7:0] b,
  output reg [8:0] sum
    );
    always@(posedge clk) begin
      if(enable) begin
        sum <= a + b;
      end
      else
        sum <= 0;
    end
endmodule
