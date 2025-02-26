`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2025 09:31:16 PM
// Design Name: 
// Module Name: parity
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module parity(
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk) 
    begin 
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;
        end 

endmodule