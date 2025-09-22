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


module AddNTT#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417,
    parameter NumStage = 16
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
    import NTT_pkg::*;
    reg [$clog2(NumStage)-1:0] cnt;
    localparam int B = N/NumStage;
    
//    always @(posedge clk) begin
//      if(rst) begin
//        cnt <= 0;
//        for(int j = 0; j < N; j ++) begin
//           res[j] <= 0;
//        end
//        valido <= 0;
//      end else
//      if(enable) begin
//        for(int j = 0; j < B; j ++) begin
//            res[cnt * B + j] <= mod_add(a[cnt * B + j], b[cnt * B + j]);
//        end
//        cnt <= cnt + 1;
//        if(cnt == NumStage - 1) begin
//          valido <= 1;
//          cnt <= 0;
//        end
//        else valido <= 0;             
//      end 
//      else begin
//        valido <= 0;
//      end      
//    end
  logic [WIDTH-1:0] buffer_a [B];
  logic [WIDTH-1:0] buffer_b [B];
  logic [WIDTH-1:0] buffer_res [B];
  logic buffer_valido, buffer_enable;
  
  AddNTT_16#(.WIDTH(WIDTH), .N(B), .Q(Q)) adder0 (
    .a(buffer_a),
    .b(buffer_b),
    .clk(clk),
    .rst(rst),
    .enable(buffer_enable),
    .valido(buffer_valido),
    .res(buffer_res)
  );
  always @(posedge clk) begin
    if(rst) begin
      valido <= 0;
      cnt <= 0;
      buffer_enable <= 0;
    end
    else if (enable) begin
      for(int j = 0; j < B; j ++) begin
        buffer_a[j] <= a[cnt * B + j];
        buffer_b[j] <= b[cnt * B + j];
      end
      buffer_enable <= 1;
      if(buffer_valido) begin
        for(int j = 0; j < B; j ++) begin
          res[cnt * B + j] <= buffer_res[j];
        end
        if(cnt == NumStage - 1) begin
          valido <= 1;
          cnt <= 0;
        end
        else begin
          valido <= 0;
          cnt <= (cnt + 1);
        end
      end
      else begin
        valido <= 0;
      end
    end
  end
 
endmodule
