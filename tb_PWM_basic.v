`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 04:26:21 PM
// Design Name: 
// Module Name: tb_PWM_basic
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


module tb_PWM_basic(

    );
    localparam R = 8;
    reg [R-1:0] duty;
    reg clk, reset_n;
    wire pwm_out;  
    
    
    // instantiate uut 
    PWM_basic #(.R(R)) uut(
    .clk(clk),
    .reset_n(reset_n),
    .duty(duty),
    .pwm_out(pwm_out)
    
    );

    localparam T = 10;  
    //timer 
    initial 
    #( 7 * 2**R * T ) $stop; 
    
   
     
    always 
    begin 
    clk = 0;
    #(T / 2) ;
    clk = 1;
    #(T / 2) ;
    
    end 
    
    initial
    begin
    // issue a quick reset for 2 ns
    reset_n = 1'b0;
    duty = 0;        // Initialize duty cycle to 0
    #2
    reset_n = 1'b1; 
    duty = 0.25 * (2**R);
    repeat (2 * 2**R) @(negedge clk);
    
    duty = 0.50 * (2**R);  
    repeat (2 * 2**R) @(negedge clk);
    
    duty = 0.75 * (2**R);

    
    end 

endmodule



