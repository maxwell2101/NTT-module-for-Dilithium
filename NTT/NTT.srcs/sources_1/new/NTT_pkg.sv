`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2025 08:57:30 PM
// Design Name: 
// Module Name: NTT_pkg
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


package NTT_pkg;
    localparam int N = 256;
    localparam int Q = 8380417;
    localparam int WIDTH = 24;
    localparam int F = 8347681;
    localparam logic [WIDTH-1:0] ZETAS [0:N-1] = '{
        24'h000000, 24'h495E02, 24'h397567, 24'h396569,
        24'h4F062B, 24'h53DF73, 24'h4FE033, 24'h4F066B,
        24'h76B1AE, 24'h360DD5, 24'h28EDB0, 24'h207FE4,
        24'h397283, 24'h70894A, 24'h088192, 24'h6D3DC8,
        24'h4C7294, 24'h41E0B4, 24'h28A3D2, 24'h66528A,
        24'h4A18A7, 24'h794034, 24'h0A52EE, 24'h6B7D81,
        24'h4E9F1D, 24'h1A2877, 24'h2571DF, 24'h1649EE,
        24'h7611BD, 24'h492BB7, 24'h2AF697, 24'h22D8D5,
        24'h36F72A, 24'h30911E, 24'h29D13F, 24'h492673,
        24'h50685F, 24'h2010A2, 24'h3887F7, 24'h11B2C3,
        24'h0603A4, 24'h0E2BED, 24'h10B72C, 24'h4A5F35,
        24'h1F9D15, 24'h428CD4, 24'h3177F4, 24'h20E612,
        24'h341C1D, 24'h1AD873, 24'h736681, 24'h49553F,
        24'h3952F6, 24'h62564A, 24'h65AD05, 24'h439A1C,
        24'h53AA5F, 24'h30B622, 24'h087F38, 24'h3B0E6D,
        24'h2C83DA, 24'h1C496E, 24'h330E2B, 24'h1C5B70,
        24'h2EE3F1, 24'h137EB9, 24'h57A930, 24'h3AC6EF,
        24'h3FD54C, 24'h4EB2EA, 24'h503EE1, 24'h7BB175,
        24'h2648B4, 24'h1EF256, 24'h1D90A2, 24'h45A6D4,
        24'h2AE59B, 24'h52589C, 24'h6EF1F5, 24'h3F7288,
        24'h175102, 24'h075D59, 24'h1187BA, 24'h52ACA9,
        24'h773E9E, 24'h0296D8, 24'h2592EC, 24'h4CFF12,
        24'h404CE8, 24'h4AA582, 24'h1E54E6, 24'h4F16C1,
        24'h1A7E79, 24'h03978F, 24'h4E4817, 24'h31B859,
        24'h5884CC, 24'h1B4827, 24'h5B63D0, 24'h5D787A,
        24'h35225E, 24'h400C7E, 24'h6C09D1, 24'h5BD532,
        24'h6BC4D3, 24'h258ECB, 24'h2E534C, 24'h097A6C,
        24'h3B8820, 24'h6D285C, 24'h2CA4F8, 24'h337CAA,
        24'h14B2A0, 24'h558536, 24'h28F186, 24'h55795D,
        24'h4AF670, 24'h234A86, 24'h75E826, 24'h78DE66,
        24'h05528C, 24'h7ADF59, 24'h0F6E17, 24'h5BF3DA,
        24'h459B7E, 24'h628B34, 24'h5DBECB, 24'h1A9E7B,
        24'h0006D9, 24'h6257C5, 24'h574B3C, 24'h69A8EF,
        24'h289838, 24'h64B5FE, 24'h7EF8F5, 24'h2A4E78,
        24'h120A23, 24'h0154A8, 24'h09B7FF, 24'h435E87,
        24'h437FF8, 24'h5CD5B4, 24'h4DC04E, 24'h4728AF,
        24'h7F735D, 24'h0C8D0D, 24'h0F66D5, 24'h5A6D80,
        24'h61AB98, 24'h185D96, 24'h437F31, 24'h468298,
        24'h662960, 24'h4BD579, 24'h28DE06, 24'h465D8D,
        24'h49B0E3, 24'h09B434, 24'h7C0DB3, 24'h5A68B0,
        24'h409BA9, 24'h64D3D5, 24'h21762A, 24'h658591,
        24'h246E39, 24'h48C39B, 24'h7BC759, 24'h4F5859,
        24'h392DB2, 24'h230923, 24'h12EB67, 24'h454DF2,
        24'h30C31C, 24'h285424, 24'h13232E, 24'h7FAF80,
        24'h2DBFCB, 24'h022A0B, 24'h7E832C, 24'h26587A,
        24'h6B3375, 24'h095B76, 24'h6BE1CC, 24'h5E061E,
        24'h78E00D, 24'h628C37, 24'h3DA604, 24'h4AE53C,
        24'h1F1D68, 24'h6330BB, 24'h7361B8, 24'h5EA06C,
        24'h671AC7, 24'h201FC6, 24'h5BA4FF, 24'h60D772,
        24'h08F201, 24'h6DE024, 24'h080E6D, 24'h56038E,
        24'h695688, 24'h1E6D3E, 24'h2603BD, 24'h6A9DFA,
        24'h07C017, 24'h6DBFD4, 24'h74D0BD, 24'h63E1E3,
        24'h519573, 24'h7AB60D, 24'h2867BA, 24'h2DECD4,
        24'h58018C, 24'h3F4CF5, 24'h0B7009, 24'h427E23,
        24'h3CBD37, 24'h273333, 24'h673957, 24'h1A4B5D,
        24'h196926, 24'h1EF206, 24'h11C14E, 24'h4C76C8,
        24'h3CF42F, 24'h7FB19A, 24'h6AF66C, 24'h2E1669,
        24'h3352D6, 24'h034760, 24'h085260, 24'h741E78,
        24'h2F6316, 24'h6F0A11, 24'h07C0F1, 24'h776D0B,
        24'h0D1FF0, 24'h345824, 24'h0223D4, 24'h68C559,
        24'h5E8885, 24'h2FAA32, 24'h23FC65, 24'h5E6942,
        24'h51E0ED, 24'h65ADB3, 24'h2CA5E6, 24'h79E1FE,
        24'h7B4064, 24'h35E1DD, 24'h433AAC, 24'h464ADE,
        24'h1CFE14, 24'h73F1CE, 24'h10170E, 24'h74B6D7
      };
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
    function automatic logic [$clog2(N)-1:0] reverse(input logic [$clog2(N)-1:0] a);
      logic [$clog2(N)-1:0] dout;
      for (int i = 0; i < $bits(a); i++) begin
        dout[i] = a[$clog2(N)-1-i];
      end
      return dout;
    endfunction

endpackage