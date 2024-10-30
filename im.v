`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:53:15 10/28/2024 
// Design Name: 
// Module Name:    im 
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
module im(
    input [31:0] pc,
    output [31:0] instr
    );

   reg [31:0] rom[0:4095];
   wire [31:0] pc_minus_three_thousand;
    wire [13:2] addr;
    
    integer i;
   initial begin
    for (i = 0; i < 4096; i=i+1)begin
      rom[i] = 32'b0;
    end
     $readmemh("code.txt", rom);
   end

    assign pc_minus_three_thousand = pc - 32'h3000;
    assign addr = pc_minus_three_thousand[13:2];
    assign instr = rom[addr];
  //  always @(*)begin
  //    for (i = 0; i < 10; i=i+1)begin
  //     $display("%h", rom[i]);
  //   end
  //  end
endmodule
