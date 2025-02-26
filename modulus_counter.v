`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 09:38:55 PM
// Design Name: 
// Module Name: modulus_counter
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

// counter up to a specific number and repeat again from 0
module modulus_counter

    #(parameter BITS = 4)
    
    ( 
    input clk, enable, reset_n,
    input [BITS-1:0] Final_value, // the number we want to count up to 
    output [BITS-1:0] Q

    );
    
    reg [BITS-1:0] Q_next, Q_reg;
    wire done;
    
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
    
    assign done = Q_reg == Final_value;
    always @(*)
    begin 
    Q_next = done? 0: Q_reg+1;  // if we want to make it down >> Q_reg-1 
    end
    
    assign Q = Q_reg; 
endmodule
