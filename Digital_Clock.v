`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 08:33:35 PM
// Design Name: 
// Module Name: Digital_Clock
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

module Digital_Clock(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
); 
    reg [7:0] hh_d, mm_d, ss_d ; 
    function [7:0] bcd;
        input [7:0] in; // Explicitly declare 'in' as an input
        begin
            bcd[3:0] = in % 10;
            bcd[7:4] = in / 10;
        end
    endfunction
    assign ss = bcd(ss_d);
    assign mm = bcd(mm_d);
    assign hh = bcd(hh_d);

//    assign ss = { (ss_d / 10)[3:0], (ss_d % 10)[3:0] };
//    assign mm = { (mm_d / 10)[3:0], (mm_d % 10)[3:0] };
//    assign hh = { (hh_d / 10)[3:0], (hh_d % 10)[3:0] };
    
    always @(posedge clk) 
    begin 
        if (reset)
            pm <= 0 ; 
        else if (ena && mm_d == 59 && ss_d == 59 && hh_d == 11 )
            pm <= ~ pm ;  
    end    
    // seconds counter 
    always @(posedge clk) 
    begin 
        if (reset)
            ss_d <= 0 ; 
                 
        else if (ena)
            ss_d <= (ss_d ==59 )? 0: ss_d+1 ;  
    end    
        // Minutes counter 
    always @(posedge clk) 
    begin 
        if (reset)
            mm_d <= 0 ; 
        // increment up to 59 when seconds = 59, with enable 
        else if (ena && ss_d == 59)
            mm_d <= (mm_d ==59 )? 0: mm_d+1 ;   
    end 

        // Hours counter 
    always @(posedge clk) 
    begin 
        if (reset)
            hh_d <= 12 ; 
        // increment up to 12 when minues and seconds = 59, with enable 
        else if (ena && ss_d == 59 && mm_d ==59)
            hh_d <= (hh_d == 12 )? 1: hh_d+1 ;   
    end 

    endmodule 








