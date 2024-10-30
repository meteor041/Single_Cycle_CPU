`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:23:14 10/29/2024 
// Design Name: 
// Module Name:    nxtad 
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
module nxtad(
    input [31:0] pc,
    input [31:0] instr,
    input [31:0] gpr_rs,
    input jump,
    input jr,
    input zero,
    input branch,
    output [31:0] next_pc,
    output [31:0] pc_plus_four
    );

    wire [15:0] imm;
    wire [31:0] sign_imm;
    wire [31:0] beq_result;
    wire [31:0] jump_result;
    wire [31:0] jr_result;

    // PC+4
    assign pc_plus_four = pc + 32'd4;
    // 立即数
    assign imm = instr[15:0];
    // 立即数符号位扩展为32位
    assign sign_imm = {{16{imm[15]}}, imm};
    // beq跳转地址
    assign beq_result = pc_plus_four + (sign_imm << 2);
    // jump跳转地址(本文件中指jal指令)
    assign jump_result = {pc_plus_four[31:28], instr[25:0], 2'b0};
    // jr跳转地址
    assign jr_result = gpr_rs;

    assign next_pc = (jr == 1) ? jr_result :
                     (jump == 1) ? jump_result :
                     ((branch && zero) == 1) ? beq_result :
                     pc_plus_four;
endmodule
