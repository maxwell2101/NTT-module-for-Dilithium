`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2025 11:34:16 PM
// Design Name: 
// Module Name: NTT_inverse
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


module NTT_inverse#(
    parameter WIDTH = 24,
    parameter N = 256,
    parameter Q = 8380417,
    parameter F = 8347681
)
(
    input bit clk,
    input bit rst,
    input bit enable,
    input [WIDTH-1:0] a [0:N-1],
    output reg valido,
    output reg [WIDTH-1:0] res [0:N-1]
);
    import NTT8_pkg::*;
    localparam int MODE_FWD = 3'd0;
    localparam int MODE_INV = 3'd1;

    reg [$clog2(N)-1:0] m, reverse_m;
    reg [$clog2(N):0] len;
    assign reverse_m = reverse(m);
    reg [$clog2(N):0] i = 0, j = 0, k = 0, reverse_j, reverse_jlen;
//    assign reverse_j = reverse(j);
//    assign reverse_jlen = reverse(j + len);
    reg [$clog2(N)-1:0] id_i, idlen_i, id_o, idlen_o;
    integer bf_z = 0;
    reg bf_rst, bf_running, bf_validi, bf_valido;
    reg [2:0] bf_mode;
    reg [WIDTH-1:0] bf_aj, bf_ajlen, bf_bj, bf_bjlen;
    integer bf_zeta;
    reg valido0;    
    butterfly #(.WIDTH(WIDTH), .N(N), .Q(Q)) but1 (
    .clk(clk),
    .rst(rst),
    .mode(bf_mode),
    .validi(bf_validi),
    .zeta(bf_zeta),
    .aj(bf_aj),
    .ajlen(bf_ajlen),
    .bj(bf_bj),
    .bjlen(bf_bjlen),
    .valido(bf_valido),
    .id_i(id_i),
    .idlen_i(idlen_i),
    .id_o(id_o),
    .idlen_o(idlen_o)   
    );
    
    reg [$clog2(N)-1:0] stage_wr, stage_rd;
    reg en_counter;
    
    always @(posedge clk) begin                
      if(rst) begin
        bf_rst <= 1; 
        bf_running <= 0;
        en_counter <= 0;
        i <= 0; 
        j <= 0; 
        m <= N - 1;
        len <= 1;
        bf_validi <= 0;
        valido0 <= 0;
        valido <= 0;
      end 
      else begin
      // initial stage: load default value
        if(enable) begin
          for (int i = 0; i < N; i ++) begin
            res[i] <= a[i];
          end
          valido0 <= 0;
          valido <= 0;
          bf_running <= 1;
          en_counter <= 1;
          len <= 1;
          i <= 0;
          j <= 0;
          m <= N - 1;
          stage_rd <= 0;
          stage_wr <= 0;
          bf_mode <= MODE_INV;
        end          
        if(bf_running) begin
        // stage 1: load data input for butterfly core
          bf_aj <= res[j];
          bf_ajlen <= res[j+len];
          id_i <= j;
          idlen_i <= j+len;
          bf_zeta <= (Q - ZETAS[reverse_m]) % Q;
          
          if(stage_wr == stage_rd) begin
            bf_validi <= bf_running;
            en_counter <= 1;
            if(len >= N) begin
              valido0 <= 1;
              en_counter <= 0;
              bf_validi <= 0;
            end
          end 
          else begin
            bf_validi <= 0;
            en_counter <= 0;
          end  
          if(en_counter) begin
            if(i >= N) begin
              i <= 0;
              len <= len * 2;                   
            end 
            else begin
              if(j >= i + len - 1) begin
                m <= m - 1;
                if(i + 2 * len >= N) begin
                  j <= 0;
                  i <= 0;
                  len <= len * 2;
                  stage_rd <= stage_rd + 1;
                  en_counter <= 0;
                end
                else begin
                  j <= i + 2 * len;
                  i <= i + 2 * len; 
                end                           
              end
              else begin
                j <= j + 1;
              end
            end                               
          end
          else begin
            //do nothing because en_counter == 0
            i <= i;
            j <= j;            
          end
          // stage 4: write back to res 
          if(bf_valido) begin                    
            res[id_o] <= bf_bj;
            res[idlen_o] <= bf_bjlen;
            // update write stage when receive last member index
            if(idlen_o == N - 1) begin
              stage_wr <= stage_wr + 1;
            end
          end
          if(valido0) begin
            for(int j = 0; j < N; j ++) begin
              res[j] <= (res[j] * F) % Q;
            end
            bf_running <= 0;
            valido <= 1;
          end        
        end                  
      end
    end
    
endmodule

