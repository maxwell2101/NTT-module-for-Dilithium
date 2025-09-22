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


module MatrixVectorNTT#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417,
    parameter L = 7,
    parameter K = 8
)
(
    input bit              clk,
    input bit              rst,
    input bit              enable,
    input [WIDTH-1:0]      vector_a [K][L][N],
    input [WIDTH-1:0]      vector_b [L][N],
    output reg             valido   [K][L],
    output reg [WIDTH-1:0] res      [K][N]
    );
    reg [WIDTH-1:0] mul_res [K][L][N];
    genvar i, j;
    generate
      for(i = 0; i < K; i ++) begin
        for(j = 0; j < L; j ++) begin
          MultiplyNTT #(.WIDTH(WIDTH), .N(N), .Q(Q), .L(L)) u_mul (
          .clk(clk),
          .rst(rst),
          .enable(enable),
          .a(vector_a[i][j]),
          .b(vector_b[j]),
          .valido(valido[i][j]),
          .res(mul_res[i][j])
          );
          AddNTT #(.WIDTH(WIDTH), .N(N), .Q(Q)) u_add (
          .clk(clk),
          .rst(rst),
          .enable(enable),
          .a(mul_res[i][j]),
          .b(res[i]),
          .valido(valido[i][j]),
          .res(res[i])
          );
        end
      end
    endgenerate
endmodule