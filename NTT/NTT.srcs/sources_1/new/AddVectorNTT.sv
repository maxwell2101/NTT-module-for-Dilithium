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


module AddVectorNTT#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417,
    parameter L = 7,
    parameter NumStage = 4
)
(
    input bit clk,
    input bit rst,
    input bit enable,
    input [WIDTH-1:0] vector_a [L][N],
    input [WIDTH-1:0] vector_b [L][N],
    output reg valido,
    output reg [WIDTH-1:0] res [L][N]
    );
//    localparam K = (L % NumStage == 0)? (L/NumStage) : (L/NumStage)+1; 
    localparam K = 2;
    (*ram_style="block" *) reg [WIDTH-1:0] buffer_a [K][N];
    reg [WIDTH-1:0] buffer_b [K][N];
    reg [WIDTH-1:0] buffer_res [K][N];
    reg buffer_valido [K];
    reg [2:0] counter;
    genvar j;
    generate
      for(j = 0; j < K; j ++) begin
        AddNTT #(.WIDTH(WIDTH), .N(N), .Q(Q)) u_add (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .a(buffer_a[j]),
        .b(buffer_b[j]),
        .valido(buffer_valido[j]),
        .res(buffer_res[j])
        );
      end
    endgenerate
    always @(posedge clk) begin
      if(rst) begin
        valido <= 0;
        counter <= 0;
      end
      else if(enable) begin
        if(counter + K <= L) begin
          for(int i = 0; i < K; i ++) begin
            for(int j = 0; j < N; j ++) begin
              buffer_a[i][j] <= vector_a[counter + i][j];
              buffer_b[i][j] <= vector_b[counter + i][j];            
            end
          end
          if(buffer_valido[counter]) begin
            if(counter + K == L) begin
              valido <= 1;
              counter <= 0;
            end
            else begin
              counter <= counter + K;
              valido <= 0;
            end
            for(int i = 0; i < K; i ++) begin
              for(int j = 0; j < N; j ++) begin
                res[counter + i][j] <= buffer_res[i][j];          
              end
            end
          end
        end
        else begin
          for(int i = 0; i < (L % K); i ++) begin
            for(int j = 0; j < N; j ++) begin
              buffer_a[i][j] <= vector_a[counter + i][j];
              buffer_b[i][j] <= vector_b[counter + i][j];            
            end
          end
          if(buffer_valido[counter]) begin
            for(int i = 0; i < K; i ++) begin
              for(int j = 0; j < N; j ++) begin
                res[counter + i][j] <= buffer_res[i][j];          
              end
            end
            valido <= 1;
            counter <= 0;
          end
          else begin
            valido <= 0;
          end
        end        
      end
      else begin
        valido <= 0;
      end
    end
endmodule
