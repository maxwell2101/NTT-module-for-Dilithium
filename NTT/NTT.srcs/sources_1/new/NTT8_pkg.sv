`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 09:56:15 PM
// Design Name: 
// Module Name: NTT8_pkg
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

package NTT8_pkg;
    localparam int N = 8;
    localparam int Q = 113;
    localparam int WIDTH = 7;
    localparam int F = 99;
    localparam logic [WIDTH-1:0] ZETAS [0:N-1] = '{
        7'd00, 7'd42, 7'd69, 7'd73,
        7'd15, 7'd65, 7'd18, 7'd78
      };
    
    function automatic logic [$clog2(N)-1:0] reverse(input logic [$clog2(N)-1:0] a);
      logic [$clog2(N)-1:0] dout;
      for (int i = 0; i < $bits(a); i++) begin
        dout[i] = a[$clog2(N)-1-i];
      end
      return dout;
    endfunction

endpackage