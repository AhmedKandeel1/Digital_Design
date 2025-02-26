`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 04:12:57 PM
// Design Name: 
// Module Name: PWM_basic
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


module PWM_basic
#(parameter R = 8)
(
    input clk, 
    input reset_n,
    input [R-1:0] duty,
    output pwm_out
);

    reg [R-1:0] Q_next, Q_reg;

    // Sequential logic: Update Q_reg with Q_next on clock edge
    always @(posedge clk or negedge reset_n) 
    begin 
        if (!reset_n)
            Q_reg <= 'b0; // Reset the counter to 0
        else
            Q_reg <= Q_next; // Update the counter
    end 

    // Combinational logic: Calculate the next state of the counter
    always @(*)
    begin 
        Q_next = Q_reg + 1; // Increment the counter
    end

    // Output logic: Generate PWM signal
    assign pwm_out = (Q_reg < duty); // PWM is high when Q_reg < duty

endmodule


