/*
   This file was generated automatically by Alchitry Labs version 1.2.0.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module shifter_19 (
    input [15:0] a,
    input [3:0] b,
    input [5:0] alufn_signal,
    output reg [15:0] out
  );
  
  
  
  always @* begin
    
    case (alufn_signal)
      default: begin
        out = a;
      end
      6'h20: begin
        out = a << b;
      end
      6'h21: begin
        out = a >> b;
      end
      6'h23: begin
        out = $signed(a) >>> b;
      end
    endcase
  end
endmodule
