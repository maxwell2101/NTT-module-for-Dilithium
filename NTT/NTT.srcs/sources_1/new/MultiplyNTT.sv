`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2025 07:09:50 PM
// Design Name: 
// Module Name: MultiplyNTT
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


module MultiplyNTT#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417
)
(
    input bit clk,
    input bit rst,
    input bit enable,
    input [WIDTH-1:0] a [0:N-1],
    input [WIDTH-1:0] b [0:N-1],
    output reg valido,
    output reg [WIDTH-1:0] res [0:N-1]
    );
    always @(posedge clk) begin
      for(int j = 0; j < N; j ++) begin
        res[j] <= (a[j] * b[j]) % Q;
      end
      valido <= 1;
    end
endmodule
