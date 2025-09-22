`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2025 03:07:58 AM
// Design Name: 
// Module Name: AddNTT_16
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


module AddNTT_16#(
    parameter WIDTH = 24,
    parameter N = 16,
    parameter Q = 8380417
)
(
    input bit clk,
    input bit rst,
    input bit enable,
    input [WIDTH-1:0] a [N],
    input [WIDTH-1:0] b [N],
    output reg valido,
    output reg [WIDTH-1:0] res [N]
    );
    import NTT_pkg::*;
    
    always @(posedge clk) begin
      if(rst) begin
        valido <= 0;
      end else
      if(enable) begin
        for(int j = 0; j < N; j ++) begin
            res[j] <= mod_add(a[j], b[j]);
        end
        valido <= 1;    
      end 
      else begin
        valido <= 0;
      end      
    end
endmodule