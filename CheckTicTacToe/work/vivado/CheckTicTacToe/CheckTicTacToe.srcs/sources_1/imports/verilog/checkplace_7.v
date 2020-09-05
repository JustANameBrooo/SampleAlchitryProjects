/*
   This file was generated automatically by Alchitry Labs version 1.1.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module checkplace_7 (
    input clk,
    input rst,
    input psel,
    input [1:0] asel,
    input [8:0] user,
    input p1en,
    input p2en,
    input [5:0] alufn,
    output reg [8:0] p1,
    output reg [8:0] p2,
    output reg [15:0] aluout,
    output reg [8:0] debug
  );
  
  
  
  wire [9-1:0] M_p1reg_out;
  reg [1-1:0] M_p1reg_en;
  reg [9-1:0] M_p1reg_data;
  register_8 p1reg (
    .clk(clk),
    .rst(rst),
    .en(M_p1reg_en),
    .data(M_p1reg_data),
    .out(M_p1reg_out)
  );
  wire [9-1:0] M_p2reg_out;
  reg [1-1:0] M_p2reg_en;
  reg [9-1:0] M_p2reg_data;
  register_8 p2reg (
    .clk(clk),
    .rst(rst),
    .en(M_p2reg_en),
    .data(M_p2reg_data),
    .out(M_p2reg_out)
  );
  
  wire [16-1:0] M_alu_out;
  wire [1-1:0] M_alu_z;
  wire [1-1:0] M_alu_v;
  wire [1-1:0] M_alu_n;
  reg [16-1:0] M_alu_a;
  reg [16-1:0] M_alu_b;
  reg [6-1:0] M_alu_alufn;
  alu16_9 alu (
    .a(M_alu_a),
    .b(M_alu_b),
    .alufn(M_alu_alufn),
    .out(M_alu_out),
    .z(M_alu_z),
    .v(M_alu_v),
    .n(M_alu_n)
  );
  
  always @* begin
    M_p1reg_en = p1en;
    M_p2reg_en = p2en;
    debug = alufn;
    M_alu_alufn = alufn;
    M_alu_a = 1'h0;
    M_alu_b = 1'h0;
    M_p1reg_data = M_alu_out[0+8-:9];
    M_p2reg_data = M_alu_out[0+8-:9];
    
    case (psel)
      1'h0: begin
        M_alu_b[0+8-:9] = M_p1reg_out;
      end
      1'h1: begin
        M_alu_b[0+8-:9] = M_p2reg_out;
      end
    endcase
    
    case (asel)
      1'h0: begin
        M_alu_a[0+8-:9] = user;
      end
      1'h1: begin
        M_alu_a[0+8-:9] = M_p1reg_out;
      end
      2'h2: begin
        M_alu_a[0+8-:9] = M_p2reg_out;
      end
      default: begin
        M_alu_a[0+8-:9] = user;
      end
    endcase
    p1 = M_p1reg_out;
    p2 = M_p2reg_out;
    aluout = M_alu_out;
  end
endmodule