`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 11:15:31 PM
// Design Name: 
// Module Name: Frequency_divider
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


module Frequency_divider(

    input clk,
    input reset,
    output OneHertz,
    output [3:0] Q0, Q1,Q2, 
    output [2:0] c_enable
); //

    assign c_enable [0] = 1 ; // first counter always runs 
    assign c_enable [1] = (Q0 == 9 ) ; // 2nd runs only when the first counter is done 
    assign c_enable [2] = c_enable [1] && (Q1 == 9 ) ; // 3rd runs only when the 1st and 2nd are done 
    
    BCD_count counter0 (clk, reset, c_enable[0],Q0) ;
    BCD_count counter1 (clk, reset, c_enable[1],Q1);
    BCD_count counter2(clk, reset, c_enable[2],Q2) ;
    
    assign OneHertz = (Q0==9) && (Q1==9) && (Q2==9) ; 
    

endmodule