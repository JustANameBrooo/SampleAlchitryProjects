/*
   This file was generated automatically by Alchitry Labs version 1.2.0.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module game_CU_11 (
    input clk,
    input rst,
    input increase_counter,
    input decrease_timer,
    input [15:0] regfile_datain,
    input p1_button,
    input p2_button,
    output reg [5:0] alufn,
    output reg [2:0] asel,
    output reg [2:0] bsel,
    output reg [1:0] alu_out_sel,
    output reg [3:0] regfile_write_address,
    output reg [3:0] regfile_read_address_a,
    output reg [3:0] regfile_read_address_b,
    output reg we_regfile,
    output reg decimal_counter_increase,
    output reg decimal_counter_rst,
    output reg [3:0] debug
  );
  
  
  
  localparam START_SET_TIMER_game_fsm = 5'd0;
  localparam INC_COUNTER_game_fsm = 5'd1;
  localparam IDLE_game_fsm = 5'd2;
  localparam CHECK_P1BUTTONCOUNT_game_fsm = 5'd3;
  localparam BRANCH_P1BUTTON_game_fsm = 5'd4;
  localparam INCREASE_P1SCORE_game_fsm = 5'd5;
  localparam INCREASE_P1BUTTONCOUNT_game_fsm = 5'd6;
  localparam CHECK_P2BUTTONCOUNT_game_fsm = 5'd7;
  localparam BRANCH_P2BUTTON_game_fsm = 5'd8;
  localparam INCREASE_P2SCORE_game_fsm = 5'd9;
  localparam INCREASE_P2BUTTONCOUNT_game_fsm = 5'd10;
  localparam RESET_COUNTER_game_fsm = 5'd11;
  localparam DECREASE_GAMETIMER_game_fsm = 5'd12;
  localparam CHECK_GAMETIMER_game_fsm = 5'd13;
  localparam BRANCH_GAMETIMER_game_fsm = 5'd14;
  localparam CHECK_P1P2BUTTONCOUNT_game_fsm = 5'd15;
  localparam BRANCHCHECK_P1P2BUTTONCOUNT_game_fsm = 5'd16;
  localparam BRANCH_P1BUTTONCOUNT_game_fsm = 5'd17;
  localparam CHECK_DRAW_game_fsm = 5'd18;
  localparam BRANCH_DRAW_game_fsm = 5'd19;
  localparam DRAW_game_fsm = 5'd20;
  localparam CHECK_WINNER_game_fsm = 5'd21;
  localparam BRANCH_WINNER_game_fsm = 5'd22;
  localparam P1WINS_game_fsm = 5'd23;
  localparam P2LOSE_game_fsm = 5'd24;
  localparam P2WINS_game_fsm = 5'd25;
  localparam P1LOSE_game_fsm = 5'd26;
  localparam GAMEOVER_game_fsm = 5'd27;
  
  reg [4:0] M_game_fsm_d, M_game_fsm_q = START_SET_TIMER_game_fsm;
  
  always @* begin
    M_game_fsm_d = M_game_fsm_q;
    
    alufn = 1'h0;
    asel = 1'h0;
    bsel = 1'h0;
    we_regfile = 1'h0;
    regfile_write_address = 11'h457;
    regfile_read_address_a = 1'h0;
    regfile_read_address_b = 1'h0;
    alu_out_sel = 1'h0;
    debug = 4'h0;
    decimal_counter_increase = 1'h0;
    decimal_counter_rst = 1'h0;
    if (rst) begin
      M_game_fsm_d = START_SET_TIMER_game_fsm;
      decimal_counter_rst = 1'h1;
    end else begin
      
      case (M_game_fsm_q)
        START_SET_TIMER_game_fsm: begin
          alufn = 6'h1a;
          asel = 2'h3;
          we_regfile = 1'h1;
          regfile_write_address = 4'h8;
          regfile_read_address_b = 4'h8;
          if (regfile_datain[4+0-:1]) begin
            M_game_fsm_d = INC_COUNTER_game_fsm;
          end else begin
            M_game_fsm_d = START_SET_TIMER_game_fsm;
          end
        end
        INC_COUNTER_game_fsm: begin
          alufn = 6'h00;
          regfile_read_address_a = 4'h7;
          bsel = 2'h1;
          asel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'h7;
          decimal_counter_increase = 1'h1;
          M_game_fsm_d = IDLE_game_fsm;
        end
        CHECK_P1BUTTONCOUNT_game_fsm: begin
          alufn = 6'h35;
          regfile_read_address_a = 4'h2;
          bsel = 2'h3;
          asel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCH_P1BUTTON_game_fsm;
        end
        BRANCH_P1BUTTON_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            M_game_fsm_d = INCREASE_P1SCORE_game_fsm;
          end else begin
            M_game_fsm_d = IDLE_game_fsm;
          end
        end
        INCREASE_P1SCORE_game_fsm: begin
          alufn = 6'h00;
          regfile_read_address_b = 4'h0;
          regfile_read_address_a = 4'h7;
          bsel = 2'h0;
          asel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'h0;
          M_game_fsm_d = INCREASE_P1BUTTONCOUNT_game_fsm;
        end
        INCREASE_P1BUTTONCOUNT_game_fsm: begin
          alufn = 6'h00;
          regfile_read_address_b = 4'h2;
          bsel = 2'h0;
          asel = 2'h1;
          we_regfile = 1'h1;
          regfile_write_address = 4'h2;
          M_game_fsm_d = RESET_COUNTER_game_fsm;
        end
        CHECK_P2BUTTONCOUNT_game_fsm: begin
          alufn = 6'h35;
          regfile_read_address_a = 4'h3;
          bsel = 2'h3;
          asel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCH_P2BUTTON_game_fsm;
        end
        BRANCH_P2BUTTON_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            M_game_fsm_d = INCREASE_P2SCORE_game_fsm;
          end else begin
            M_game_fsm_d = IDLE_game_fsm;
          end
        end
        INCREASE_P2SCORE_game_fsm: begin
          alufn = 6'h00;
          regfile_read_address_b = 4'h1;
          regfile_read_address_a = 4'h7;
          bsel = 2'h0;
          asel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'h1;
          M_game_fsm_d = INCREASE_P2BUTTONCOUNT_game_fsm;
        end
        INCREASE_P2BUTTONCOUNT_game_fsm: begin
          alufn = 6'h00;
          regfile_read_address_b = 4'h3;
          bsel = 2'h0;
          asel = 2'h1;
          we_regfile = 1'h1;
          regfile_write_address = 4'h3;
          M_game_fsm_d = RESET_COUNTER_game_fsm;
        end
        RESET_COUNTER_game_fsm: begin
          alu_out_sel = 2'h3;
          we_regfile = 1'h1;
          regfile_write_address = 4'h7;
          decimal_counter_rst = 1'h1;
          decimal_counter_increase = 1'h0;
          M_game_fsm_d = CHECK_P1P2BUTTONCOUNT_game_fsm;
        end
        DECREASE_GAMETIMER_game_fsm: begin
          alufn = 6'h01;
          regfile_read_address_a = 4'h8;
          asel = 2'h0;
          bsel = 2'h1;
          we_regfile = 1'h1;
          regfile_write_address = 4'h8;
          M_game_fsm_d = IDLE_game_fsm;
        end
        CHECK_GAMETIMER_game_fsm: begin
          alufn = 6'h33;
          regfile_read_address_a = 4'h8;
          asel = 2'h0;
          bsel = 2'h2;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCH_GAMETIMER_game_fsm;
        end
        BRANCH_GAMETIMER_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (~regfile_datain[0+0-:1]) begin
            M_game_fsm_d = DECREASE_GAMETIMER_game_fsm;
          end else begin
            M_game_fsm_d = CHECK_DRAW_game_fsm;
          end
        end
        CHECK_P1P2BUTTONCOUNT_game_fsm: begin
          alufn = 6'h33;
          regfile_read_address_a = 4'h2;
          regfile_read_address_b = 4'h3;
          asel = 2'h0;
          bsel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCHCHECK_P1P2BUTTONCOUNT_game_fsm;
        end
        BRANCHCHECK_P1P2BUTTONCOUNT_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            alufn = 6'h33;
            regfile_read_address_a = 4'h2;
            bsel = 2'h3;
            we_regfile = 1'h1;
            regfile_write_address = 4'hf;
            M_game_fsm_d = BRANCH_P1BUTTONCOUNT_game_fsm;
          end else begin
            M_game_fsm_d = IDLE_game_fsm;
          end
        end
        BRANCH_P1BUTTONCOUNT_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            M_game_fsm_d = CHECK_DRAW_game_fsm;
          end else begin
            M_game_fsm_d = IDLE_game_fsm;
          end
        end
        CHECK_DRAW_game_fsm: begin
          alufn = 6'h33;
          regfile_read_address_a = 4'h0;
          regfile_read_address_b = 4'h1;
          asel = 2'h0;
          bsel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCH_DRAW_game_fsm;
        end
        BRANCH_DRAW_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            alu_out_sel = 2'h2;
            we_regfile = 1'h1;
            regfile_write_address = 4'h0;
            M_game_fsm_d = DRAW_game_fsm;
          end else begin
            M_game_fsm_d = CHECK_WINNER_game_fsm;
          end
        end
        DRAW_game_fsm: begin
          alu_out_sel = 2'h2;
          we_regfile = 1'h1;
          regfile_write_address = 4'h1;
          M_game_fsm_d = GAMEOVER_game_fsm;
        end
        CHECK_WINNER_game_fsm: begin
          alufn = 6'h35;
          regfile_read_address_a = 4'h0;
          regfile_read_address_b = 4'h1;
          asel = 2'h0;
          bsel = 2'h0;
          we_regfile = 1'h1;
          regfile_write_address = 4'hf;
          M_game_fsm_d = BRANCH_WINNER_game_fsm;
        end
        BRANCH_WINNER_game_fsm: begin
          regfile_read_address_b = 4'hf;
          if (regfile_datain[0+0-:1]) begin
            M_game_fsm_d = P2WINS_game_fsm;
          end else begin
            M_game_fsm_d = P1WINS_game_fsm;
          end
        end
        P2WINS_game_fsm: begin
          we_regfile = 1'h1;
          regfile_write_address = 4'h1;
          alu_out_sel = 2'h1;
          M_game_fsm_d = P1LOSE_game_fsm;
        end
        P1WINS_game_fsm: begin
          we_regfile = 1'h1;
          regfile_write_address = 4'h0;
          alu_out_sel = 2'h1;
          M_game_fsm_d = P2LOSE_game_fsm;
        end
        P1LOSE_game_fsm: begin
          we_regfile = 1'h1;
          regfile_write_address = 4'h0;
          alu_out_sel = 2'h3;
          M_game_fsm_d = GAMEOVER_game_fsm;
        end
        P2LOSE_game_fsm: begin
          we_regfile = 1'h1;
          regfile_write_address = 4'h1;
          alu_out_sel = 2'h3;
          M_game_fsm_d = GAMEOVER_game_fsm;
        end
        GAMEOVER_game_fsm: begin
          debug = 4'hf;
          M_game_fsm_d = GAMEOVER_game_fsm;
        end
        IDLE_game_fsm: begin
          if (decrease_timer) begin
            M_game_fsm_d = CHECK_GAMETIMER_game_fsm;
          end else begin
            if (increase_counter && ~p1_button && ~p2_button) begin
              M_game_fsm_d = INC_COUNTER_game_fsm;
            end else begin
              if (p1_button && ~p2_button) begin
                M_game_fsm_d = CHECK_P1BUTTONCOUNT_game_fsm;
              end else begin
                if (p2_button && ~p1_button) begin
                  M_game_fsm_d = CHECK_P2BUTTONCOUNT_game_fsm;
                end else begin
                  M_game_fsm_d = IDLE_game_fsm;
                end
              end
            end
          end
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    M_game_fsm_q <= M_game_fsm_d;
  end
  
endmodule
