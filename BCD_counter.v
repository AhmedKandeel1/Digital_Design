`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 09:54:52 AM
// Design Name: 
// Module Name: BCD_counter
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


module BCD_counter(
    input clk, enable, reset_n,
    output done,
    output [3:0] Q
    
    );

    reg [3:0] Q_next, Q_reg;
    
    // 
    
    always @(posedge clk, negedge reset_n ) 
    
    begin 
         if (!reset_n)
            Q_reg <= 0;
         else if (enable) 
            Q_reg <= Q_next;
            
          else
            Q_reg <= Q_reg; 
        
    end 
    
    // Next state logic 
    
    assign done = Q_reg == 9;
    always @(*)
    begin 
    Q_next = done? 0: Q_reg+1;  // if we want to make it down >> Q_reg-1 
    end
    
    assign Q = Q_reg; 
endmodule
