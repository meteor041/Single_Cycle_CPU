`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:16 10/29/2024 
// Design Name: 
// Module Name:    ctrl 
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
module ctrl(
    input [31:0] in,
    output RegWrite,
    output MemWrite,
    output [3:0] ALUControl,
    output ALUSrc,
    output MemtoReg,
    output RegDst,
    output Branch,
    output Jump,
    output ExtControl,
    output Jr,
    output Jal
    );
    wire [5:0] funct;
    wire [31:26] op;

    assign funct = in[5:0];
    assign op = in[31:26];

    wire R;

    wire add;
    wire sub;
    wire ori;
    wire lw;
    wire sw;
    wire beq;
    wire lui;
    wire jal;
    wire jr;
    wire nop;

    assign R = (op == 6'b000000) ? 1 : 0;
    assign ori = (op == 6'b001101) ? 1 : 0;
    assign lw = (op == 6'b100011) ? 1 : 0;
    assign sw = (op == 6'b101011) ? 1 : 0;
    assign beq = (op == 6'b000100) ? 1 : 0;
    assign lui = (op == 6'b001111) ? 1 : 0;
    assign jal = (op == 6'b000011) ? 1 : 0;

    // R型指令
    assign add = (R && funct == 6'b100000) ? 1 : 0;
    assign sub = (R && funct == 6'b100010) ? 1 : 0;
    assign jr = (R && funct == 6'b001000) ? 1 : 0;
    assign nop = (R && funct == 6'b000000) ? 1 : 0;

    // 信号输出
    // 写入寄存器使能信号
    assign RegWrite = R || lui || ori || lw || jal;
    // 写入Memory使能信号
    assign MemWrite = sw;
    // ALU控制信号
    assign ALUControl[0] = ori || lui;
    assign ALUControl[1] = sub || lui || lw || sw || add || beq;
    assign ALUControl[2] = sub || beq;
    assign ALUControl[3] = 0;
    // ALUSrc:ALU读入端口来源控制信号(寄存器 or 立即数)
    assign ALUSrc = lui || lw || sw || ori;
    // MemtoReg:为1时,寄存器写入数据来自Memory,否则为ALU计算结果
    assign MemtoReg = lw;
    // RegDst:寄存器写入地址端口选择信号(1->15:11, 0->20:16)
    assign RegDst = R;
    // Branch:跳转信号
    assign Branch = beq;
    // Jump:jal,j跳转信号
    assign Jump = jal;
    // ExtControl:选择Ext扩位方式
    assign ExtControl = ori || lui;
    // Jr
    assign Jr = jr;
    // Jal
    assign Jal = jal;
endmodule
