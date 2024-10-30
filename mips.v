`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:30:37 10/28/2024 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

    wire [31:0] next_pc;
    wire [31:0] pc;
    wire [31:0] pc_plus_four;
    wire [31:0] instr;
    wire [4:0] a3;

    wire [31:0] rd1;
    wire [31:0] rd2;
    wire [31:0] wd3;

    wire [31:0] src_a;
    wire [31:0] src_b;
    wire [31:0] alu_result;
    wire zero; //ALU输出零信号

    wire [31:0] ext_imm;

    wire [31:0] gpr_rs;

    wire [31:0] mem_rd;

    // 信号
    wire RegWrite;
    wire MemWrite;
    wire [3:0] ALUControl;
    wire ALUSrc;
    wire MemtoReg;
    wire RegDst;
    wire Branch;
    wire Jump;
    wire ExtControl;
    wire Jr;
    wire Jal;

    pc uvv1(.clk(clk), 
            .reset(reset), 
            .pc_in(next_pc), 
            .pc_out(pc));

    im uvv2(.pc(pc), 
            .instr(instr));

    grf uvv3(.write_enable(RegWrite), 
            .clk(clk), 
            .reset(reset), 
            .a1(instr[25:21]), 
            .a2(instr[20:16]), 
            .a3(a3),
            .rd1(rd1),
            .rd2(rd2),
            // .wpc(pc),
            .wd3(wd3));

    
    assign src_a = rd1;
    assign src_b = (ALUSrc == 1'b1) ? ext_imm : rd2;
    alu uvv4(.src_a(src_a), 
             .src_b(src_b),
             .alu_control(ALUControl),
             .alu_result(alu_result),
             .zero(zero));

    assign gpr_rs = rd1;
    nxtad uvv5(.pc(pc),
               .instr(instr),
               .gpr_rs(gpr_rs),
               .jump(Jump),
               .jr(Jr),
               .zero(zero),
               .branch(Branch),
               .next_pc(next_pc),
               .pc_plus_four(pc_plus_four));

    assign a3 = Jal ? 5'd31 :
                RegDst ? instr[15:11] :
                instr[20:16];

    dm uvv6(.clk(clk),
            .reset(reset),
            .MemWrite(MemWrite),
            .addr(alu_result),
            .din(rd2),
            // .pc(pc),
            .dout(mem_rd));

    assign wd3 = Jal ? pc_plus_four : 
                 MemtoReg ? mem_rd :
                 alu_result;
    
    ctrl uvv7(.in(instr),
              .RegWrite(RegWrite),
              .MemWrite(MemWrite),
              .ALUControl(ALUControl),
              .ALUSrc(ALUSrc),
              .MemtoReg(MemtoReg),
              .RegDst(RegDst),
              .Branch(Branch),
              .Jump(Jump),
              .ExtControl(ExtControl),
              .Jr(Jr),
              .Jal(Jal));
              
    ext uvv8(.imm16(instr[15:0]),
             .ExtControl(ExtControl),
             .imm32(ext_imm));
    always @(posedge clk)begin
        if (reset == 0)begin
            if (RegWrite == 1 && a3 != 5'b0)begin
                $display("@%h: $%d <= %h", pc, a3, wd3);
            end
            if (MemWrite == 1)begin
                $display("@%h: *%h <= %h", pc, alu_result, rd2);
            end
        end
    end
endmodule
