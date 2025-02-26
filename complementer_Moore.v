`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2025 08:40:17 AM
// Design Name: 
// Module Name: complementer_Moore
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


module complementer_Moore(
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] state_reg, next_state ;  
    localparam idle = 0 ; 
    localparam OUT_ONE = 1;
    localparam OUT_ZERO = 2 ; 
    
    always @(posedge clk, posedge areset) 
        begin 
        if (areset) 
            state_reg <= idle ;
            else 
                state_reg <= next_state ; 
        end 
    
    always @(*)
        begin 
            case (state_reg) 
               idle:  next_state = x ? OUT_ONE: idle ; 
                OUT_ONE:  next_state = x ? OUT_ZERO: OUT_ONE; 
                OUT_ZERO:  next_state = x ? OUT_ZERO: OUT_ONE;  
                default: next_state = idle ; 
            endcase 
        end 
    
    assign z = (state_reg == OUT_ONE) ;        
endmodule
