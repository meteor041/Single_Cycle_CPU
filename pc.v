`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:31:41 10/28/2024 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input clk,
    input reset,
    input [31:0] pc_in,
    output [31:0] pc_out
    );

    reg [31:0] reg_pc;

    // Compact, Data at Address 0
    initial begin
      reg_pc = 32'h3000;
    end 

    // 同步复位
    always @(posedge clk)begin
      if (reset)begin
        reg_pc <= 32'h3000;
      end
      else begin
        reg_pc <= pc_in;
      end
    end

    assign pc_out = reg_pc;
endmodule
