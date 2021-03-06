/*
   This file was generated automatically by Alchitry Labs version 1.2.0.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module beta_cpu_1 (
    input clk,
    input slowclk,
    input rst,
    input interrupt,
    input [31:0] instruction,
    input [31:0] mem_data_input,
    output reg [31:0] ia,
    output reg [31:0] mem_data_address,
    output reg [31:0] mem_data_output,
    output reg xwr,
    output reg [31:0] debug
  );
  
  
  
  wire [3-1:0] M_control_system_pcsel;
  wire [1-1:0] M_control_system_wasel;
  wire [1-1:0] M_control_system_asel;
  wire [1-1:0] M_control_system_ra2sel;
  wire [1-1:0] M_control_system_bsel;
  wire [6-1:0] M_control_system_alufn;
  wire [2-1:0] M_control_system_wdsel;
  wire [1-1:0] M_control_system_werf;
  wire [1-1:0] M_control_system_moe;
  wire [1-1:0] M_control_system_xwr;
  reg [1-1:0] M_control_system_irq;
  reg [1-1:0] M_control_system_z;
  reg [1-1:0] M_control_system_reset;
  reg [6-1:0] M_control_system_opcode;
  control_unit_6 control_system (
    .clk(clk),
    .irq(M_control_system_irq),
    .z(M_control_system_z),
    .reset(M_control_system_reset),
    .opcode(M_control_system_opcode),
    .pcsel(M_control_system_pcsel),
    .wasel(M_control_system_wasel),
    .asel(M_control_system_asel),
    .ra2sel(M_control_system_ra2sel),
    .bsel(M_control_system_bsel),
    .alufn(M_control_system_alufn),
    .wdsel(M_control_system_wdsel),
    .werf(M_control_system_werf),
    .moe(M_control_system_moe),
    .xwr(M_control_system_xwr)
  );
  
  wire [32-1:0] M_alu_system_out;
  wire [3-1:0] M_alu_system_zvn;
  reg [32-1:0] M_alu_system_a;
  reg [32-1:0] M_alu_system_b;
  reg [6-1:0] M_alu_system_alufn_signal;
  alu_7 alu_system (
    .a(M_alu_system_a),
    .b(M_alu_system_b),
    .alufn_signal(M_alu_system_alufn_signal),
    .out(M_alu_system_out),
    .zvn(M_alu_system_zvn)
  );
  
  wire [32-1:0] M_regfile_system_read_data_1;
  wire [32-1:0] M_regfile_system_read_data_2;
  reg [5-1:0] M_regfile_system_read_address_1;
  reg [5-1:0] M_regfile_system_read_address_2;
  reg [5-1:0] M_regfile_system_write_address;
  reg [32-1:0] M_regfile_system_write_data;
  reg [1-1:0] M_regfile_system_write_enable;
  regfile_8 regfile_system (
    .clk(clk),
    .read_address_1(M_regfile_system_read_address_1),
    .read_address_2(M_regfile_system_read_address_2),
    .write_address(M_regfile_system_write_address),
    .write_data(M_regfile_system_write_data),
    .write_enable(M_regfile_system_write_enable),
    .read_data_1(M_regfile_system_read_data_1),
    .read_data_2(M_regfile_system_read_data_2)
  );
  
  reg [31:0] M_pc_d, M_pc_q = 1'h0;
  
  always @* begin
    M_pc_d = M_pc_q;
    
    M_control_system_reset = rst;
    M_control_system_irq = interrupt;
    M_control_system_opcode = instruction[26+5-:6];
    ia = M_pc_q;
    if (slowclk) begin
      
      case (M_control_system_pcsel)
        3'h0: begin
          M_pc_d = M_pc_q + 3'h4;
        end
        3'h1: begin
          M_pc_d = M_pc_q + 3'h4 + 3'h4 * {instruction[15+0-:1], instruction[0+15-:16]};
        end
        3'h2: begin
          M_pc_d = {M_pc_q[31+0-:1] && M_regfile_system_read_data_1[31+0-:1], M_regfile_system_read_data_1[0+30-:31]};
        end
        3'h3: begin
          M_pc_d = 32'h00000008;
        end
        3'h4: begin
          M_pc_d = 32'h00000004;
        end
        default: begin
          M_pc_d = M_pc_q;
        end
      endcase
    end
    if (rst) begin
      M_pc_d = 32'h00000000;
    end
    
    case (M_control_system_ra2sel)
      1'h0: begin
        M_regfile_system_read_address_2 = instruction[11+4-:5];
      end
      1'h1: begin
        M_regfile_system_read_address_2 = instruction[21+4-:5];
      end
      default: begin
        M_regfile_system_read_address_2 = instruction[11+4-:5];
      end
    endcase
    
    case (M_control_system_wasel)
      1'h0: begin
        M_regfile_system_write_address = instruction[21+4-:5];
      end
      1'h1: begin
        M_regfile_system_write_address = 5'h1e;
      end
      default: begin
        M_regfile_system_write_address = instruction[21+4-:5];
      end
    endcase
    M_regfile_system_read_address_1 = instruction[16+4-:5];
    M_regfile_system_write_enable = M_control_system_werf;
    M_control_system_z = (~|M_regfile_system_read_data_1);
    mem_data_output = M_regfile_system_read_data_2;
    M_alu_system_alufn_signal = M_control_system_alufn;
    
    case (M_control_system_asel)
      1'h0: begin
        M_alu_system_a = M_regfile_system_read_data_1;
      end
      1'h1: begin
        M_alu_system_a = M_pc_q + 3'h4 + 3'h4 * {instruction[15+0-:1], instruction[0+15-:16]};
      end
      default: begin
        M_alu_system_a = M_regfile_system_read_data_1;
      end
    endcase
    
    case (M_control_system_bsel)
      1'h0: begin
        M_alu_system_b = M_regfile_system_read_data_2;
      end
      1'h1: begin
        M_alu_system_b = {instruction[15+0-:1], instruction[0+15-:16]};
      end
      default: begin
        M_alu_system_b = M_regfile_system_read_data_2;
      end
    endcase
    
    case (M_control_system_wdsel)
      2'h0: begin
        M_regfile_system_write_data = M_pc_q + 3'h4;
      end
      2'h1: begin
        M_regfile_system_write_data = M_alu_system_out;
      end
      2'h2: begin
        M_regfile_system_write_data = mem_data_input;
      end
      default: begin
        M_regfile_system_write_data = M_alu_system_out;
      end
    endcase
    mem_data_address = M_alu_system_out;
    xwr = M_control_system_xwr;
    debug = M_control_system_pcsel;
  end
  
  always @(posedge clk) begin
    M_pc_q <= M_pc_d;
  end
  
endmodule
