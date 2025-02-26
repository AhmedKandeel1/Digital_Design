`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 09:58:22 AM
// Design Name: 
// Module Name: multi_decade_counter
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


module multi_decade_counter(

    input clk, enable, reset_n,
    output done,
    output [3:0] ones, tens, hundreds
    
    );
    
    wire o1,o2,o3;
    wire done_ones, done_tens, done_hundreds;
    
    BCD_counter C1 (
    
    .clk(clk),
    .enable(enable),
    .reset_n(reset_n),
    .done(done_ones),
    .Q(ones)  
    
    );
    
    assign o1 = done_ones & enable; 
    
    
    BCD_counter C2 (
    
    .clk(clk),
    .enable(o1),
    .reset_n(reset_n),
    .done(done_tens),
    .Q(tens)  
    
    );
    
    assign o2 = done_tens & o1; 
    
    BCD_counter C3 (
    
    .clk(clk),
    .enable(o2),
    .reset_n(reset_n),
    .done(done_hundreds),
    .Q(hundreds)  
    
    );
    
    assign o3 = done_hundreds & o2; 
    assign done = o3;
    
    
endmodule
