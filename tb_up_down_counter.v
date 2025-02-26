`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/17/2025 09:29:25 PM
// Design Name: 
// Module Name: tb_up_down_counter
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


module tb_up_down_counter(
    );
    
    localparam BITS = 4;
    reg clk, up,enable, reset_n;
    wire [BITS-1:0]Q;
    
     // Instantiate the up_down_counter module
    up_down_counter #(.BITS(BITS)) uut(
    
        .clk(clk),
        .up(up),
        .enable(enable),
        .reset_n(reset_n),
        .Q(Q) 
        
        );
        
        // timer 
        initial 
        #400 $stop ;
        
        // Generate stimuli 
        
        //generate clk signal 
//       initial 
//       begin
//        clk = 0;
//        forever #5 clk = ~clk; // Toggle clock every 5 time units
//        end
        localparam T = 10;
        always begin 
        clk = 0;
        # (T / 2) ;
        clk = 1;
        # (T / 2) ;
        
        end 
        
        
        initial begin 
        
        reset_n = 0;
        enable = 0;
        
        up = 1;
        #2 reset_n = 1;
        
        repeat(2) @(negedge clk);
        enable = 1;
        
        wait (Q==15);
        enable = 0;
        
        repeat(2) @(negedge clk);
        up = 0;
        enable =1;
        
        end 

endmodule
