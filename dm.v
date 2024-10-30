`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:25 10/29/2024 
// Design Name: 
// Module Name:    dm 
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
module dm(
    input clk,
    input reset,
    input MemWrite, // memory write enable
    input [31:0] addr, // memory's address for write
    input [31:0] din, // write data
    // input [31:0] pc, // instruction address
    output [31:0] dout // read data
    );

    reg[31:0] ram [0:3071];
    integer i;

    initial begin
      for (i = 0; i < 3072; i=i+1)begin
        ram[i] = 32'h0;
      end
    end

    // read data
    assign dout = ram[addr[13:2]];
    
    // write data at posedge of clk if MemWrite=1
    always @(posedge clk)begin
      if (reset)begin
        // reset memory to initial state
        for (i = 0; i < 1024; i=i+1)begin
            ram[i] = 32'h0;
        end
      end
      else begin
        if (MemWrite)begin
          // $display("@%h: *%h <= %h", pc, addr, din);
          // write data memory
          ram[addr[13:2]] = din;
        end
      end
    end

endmodule
