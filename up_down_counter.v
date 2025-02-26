`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2025 08:48:12 PM
// Design Name: 
// Module Name: up_down_counter
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


module up_down_counter 
# (parameter BITS = 4)
(
    output [BITS-1:0] Q ,
    input clk ,
    input up,   // control signal to count up or down 
    input enable , // enable signal to stop counting 
    input reset_n  // reset signal to go back to 0 
    );
    reg [BITS-1:0] Q_next, Q_reg;   
    always @(posedge clk , negedge reset_n)
    begin 
    if (!reset_n)
        Q_reg <=0;
    else if (enable)
    /* if enable is true >> then keep counting. 
     It is a synchrounous enable, that will happen with the clk signal 
    {That's why we did not add it to the sensitivity list }*/
        Q_reg <= Q_next;
    else  //if enable = 0, STOP counting and keep the current state 
        Q_reg <= Q_reg;       
    end 
    // Next state logic 
    always @ (Q_reg,up)
    begin 
        Q_next =Q_reg; // just to make sure nothing go wrong, we can delete it. 
        
        if (up)
        Q_next =Q_reg + 1;
        else 
        Q_next =Q_reg - 1;

    end
    assign Q = Q_reg;

endmodule 
