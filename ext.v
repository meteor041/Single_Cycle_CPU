`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:21 10/29/2024 
// Design Name: 
// Module Name:    ext 
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
module ext(
    input [15:0] imm16,
    input ExtControl,
    output [31:0] imm32
    );

    // ExtControl为1时,作零扩展;0时,作符号扩展
    assign imm32 = (ExtControl == 1'b1) ? {{16{1'b0}}, imm16} :
                                       {{16{imm16[15]}}, imm16};

endmodule
