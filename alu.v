`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:08:19 10/29/2024 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(
    input [31:0] src_a,
    input [31:0] src_b,
    input [3:0] alu_control,
    output reg [31:0] alu_result,
    output zero
    );

    initial begin
      alu_result = 32'bz;
    end
    always @(*)begin
      case(alu_control)
        4'b0000:begin
          // and
          alu_result = src_a & src_b;
        end
        4'b0001:begin
          // or
          alu_result = src_a | src_b;
        end
        4'b0010:begin
          // add
          alu_result = src_a + src_b;
        end
        4'b0011:begin
          // lui
          alu_result = (src_b << 5'h10);
        end
        4'b0110:begin
          // sub
          alu_result = src_a - src_b;
        end
        default:begin
          alu_result = 4'bz;
        end
        
      endcase
      // $display("src_a : %h, src_b : %h, alu_result : %h", src_a, src_b, alu_result);
    end
    assign zero = (src_a - src_b == 0) ? 1 : 0;
endmodule
