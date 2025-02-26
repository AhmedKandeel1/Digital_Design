`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 08:45:05 PM
// Design Name: 
// Module Name: mytest
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


module mytest
#(parameter BITS = 4)
    ( 
    input clk, load ,up, enable, reset_n,
    input [BITS-1:0] D,
    output [BITS-1:0] Q

    );
    
    reg [BITS-1:0] Q_next, Q_reg;
    
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
    
    always @(*)
    begin 
    Q_next = Q_reg;
    casex({load,up})
            2'b00: Q_next = Q_reg - 1 ; // count down 
            2'b01: Q_next = Q_reg + 1 ; // count up 
            2'b1x: Q_next = D ; // If I am loading data, I do not care about counting up or down, it will continue as before loading 
            default : Q_next = Q_reg; 
    endcase 
    
    end 
    
    assign Q = Q_reg;
    
endmodule


