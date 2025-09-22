`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2025 03:00:26 PM
// Design Name: 
// Module Name: butterfly
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


module butterfly #(
    parameter int WIDTH = 24,
    parameter int N     = 256,          
    parameter int Q     = 8380417
)(
    input logic                     clk,
    input logic                     rst,
    input logic [2:0]               mode,      //3'h0: FORWARD, 3'h1: INVERSE
    input logic                     validi,
    input logic [WIDTH-1:0]         zeta,      
    input logic signed [WIDTH-1:0]  aj,        //a[j]
    input logic signed [WIDTH-1:0]  ajlen,     //a[j+len]
    input logic [$clog2(N):1]       id_i,
    input logic [$clog2(N):1]       idlen_i, 
    output logic                    valido,
    output logic [$clog2(N):1]      id_o,
    output logic [$clog2(N):1]      idlen_o, 
    output logic [WIDTH-1:0]        bj,        //b[j]
    output logic [WIDTH-1:0]        bjlen      //b[j+len]
);

    localparam int MODE_FWD = 3'd0;
    localparam int MODE_INV = 3'd1;
  
//-----------------mod Q---------------------------
    function automatic logic [WIDTH-1:0] mod_add
        (input logic [WIDTH-1:0] a, b);
        logic [WIDTH:0] s;
        begin
            s = a + b;
            mod_add = (s >= Q) ? s - Q : s[WIDTH-1:0];
        end
    endfunction

    function automatic logic [WIDTH-1:0] mod_sub
        (input logic [WIDTH-1:0] a, b);
        begin
            mod_sub = (a >= b) ? (a - b) : (a + Q - b);
        end
    endfunction
//--------------pipeline--------------------------
    logic [WIDTH-1:0]   a0, a0len, z0;
    logic [2:0]         m0;
    logic               v0;
    logic [2*WIDTH-1:0] prod0, b2len;
    logic [$clog2(N)-1:0] id0_o, id1_o;
    logic [$clog2(N)-1:0] id0len_o, id1len_o; 
    logic [WIDTH-1:0]   a1, a1len, b1, b1len, b2, t1;
    logic               v1, v2;
//--------------stage 1: load value-------------    
    always_ff @(posedge clk) begin
        if(rst) begin
            v0 <= 0;
        end else begin
            a0 <= aj;
            a0len <= ajlen;
            z0 <= zeta;
            m0 <= mode;
            v0 <= validi;
            id0_o <= id_i;
            id0len_o <= idlen_i;
            prod0 <= ajlen * zeta;
            b1 <= mod_add(aj, ajlen);
            b1len <= mod_sub(aj, ajlen);             
        end
    end
//--------------stage 2: count and reduce value---------

    always_ff @(posedge clk) begin
        if(rst) begin
            bj <= 0;
            bjlen <= 0;
            valido <= 0;
            id_o <= 0;
            idlen_o <= 0;
        end else begin
            t1 <= prod0 % Q;
            a1 <= a0;
            a1len <= a0len;
            v1 <= v0;
            b2 <= b1;
            b2len <= b1len * z0;
            id1_o <= id0_o;
            id1len_o <= id0len_o;
//--------------stage 3: write output---------
            case (m0)
                MODE_INV: begin                    
                    bj    <= b2;
                    bjlen <= b2len % Q;
                end
                MODE_FWD: begin
                    bj <= mod_add(a1, t1);
                    bjlen <= mod_sub(a1, t1);
                end
                default: begin
                end
            endcase
            valido <= v1;
            id_o <= id1_o;
            idlen_o <= id1len_o;
        end
    end  
endmodule