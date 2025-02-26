`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 02:10:54 PM
// Design Name: 
// Module Name: timer_parameter
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

// timer is based on a modulus counter 
module timer_parameter

 #(parameter Final_value = 255)   
    ( 
    input clk, enable, reset_n,
    output done

    );
// The number of bits is set based on the target final value of the counter 
    localparam BITS = $clog2(Final_value);
    
    reg [BITS-1:0] Q_next, Q_reg;    
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

endmodule
