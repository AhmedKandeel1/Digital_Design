`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 08:26:43 PM
// Design Name: 
// Module Name: BCD_count
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


module BCD_count(

    input clk, reset, enable,
    output reg [3:0]  Q

    );
    always @(posedge clk)
    begin
        if (reset)
        	Q <= 0 ;
        else if (enable)
            begin 
                if (Q == 9 ) 
                    Q <= 0 ; 
                else 
                    Q <= Q + 1  ; 
            end 
    end 


endmodule


