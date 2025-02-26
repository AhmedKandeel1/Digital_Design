`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2025 08:45:24 AM
// Design Name: 
// Module Name: complementer_Meaaly
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


module complementer_Meaaly(
    input clk,
    input areset,
    input x,
    output z
); 
    reg state_reg, next_state ;  
    localparam A = 0 ; 
    localparam B = 1;
    
    always @(posedge clk, posedge areset) 
        begin 
        if (areset) 
            state_reg <= A ;
            else 
                state_reg <= next_state ; 
        end 
    
    always @(*)
        begin 
            case (state_reg) 
               A:  next_state = x ? B: A ; 
                B:  next_state = B; 
            endcase 
        end 
    // first case in case input is only ZEROs. 
    assign z = (state_reg == A && x)|| (state_reg == B && ~x) ;        
endmodule
