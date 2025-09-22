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


module ScalarVectorNTT#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417,
    parameter L = 7
)
(
    input bit clk,
    input bit rst,
    input bit enable,
    input [WIDTH-1:0] vector_a [N],
    input [WIDTH-1:0] vector_b [L][N],
    output reg valido[L],
    output reg [WIDTH-1:0] res [L][N]
    );
    
    genvar j;
    generate
      for(j = 0; j < L; j ++) begin
        MultiplyNTT #(.WIDTH(WIDTH), .N(N), .Q(Q)) u_mul (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .a(vector_a),
        .b(vector_b[j]),
        .valido(valido[j]),
        .res(res[j])
        );
      end
    endgenerate
endmodule
