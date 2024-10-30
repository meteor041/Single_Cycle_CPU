`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:13:39 10/29/2024 
// Design Name: 
// Module Name:    grf 
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
module grf(
    input write_enable,
    input clk,
    input reset,
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    // input [31:0] wpc,
    input [31:0] wd3,
    output [31:0] rd1,
    output [31:0] rd2
    );

    reg[31:0] registers[0:31];
    integer i;
    initial begin
      for (i = 0; i < 32; i=i+1)begin
        registers[i] = 32'b0;
      end
    end

    always @(posedge clk)begin
      if (reset)begin
        for (i = 0; i < 32; i=i+1)begin
            registers[i] <= 32'b0;
        end
      end
      else begin
        if (write_enable && a3 != 5'b0)begin
            registers[a3] <= wd3;
            // $display("@%h: $%d <= %h", wpc, a3, wd3);
        end
      end
    end

    assign rd1 = registers[a1];
    assign rd2 = registers[a2];
endmodule
