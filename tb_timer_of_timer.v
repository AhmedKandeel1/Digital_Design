`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 04:21:38 PM
// Design Name: 
// Module Name: tb_timer_of_timer
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


module tb_timer_of_timer(

    );
    
    reg clk, reset; 
    wire [3:0] timer ;
    wire [6:0] control_counter ; 
    
// Instantiate the design module under test.

Controlled_counter uut (clk, reset,timer, control_counter);

// Generate stimulus, using initial and always statements.

// clock generation 
 initial 
 begin 
    clk = 0 ;
    forever #5 clk = ~ clk ;
 end 
 
    initial begin
        reset = 1;   // Start with reset active
        #20 reset = 0; // Deassert reset after 20 time units
        #1500 reset = 1 ; 
        #200 reset = 0; 
        
        // Run simulation for enough time
        #4000;
        $finish; 
    end

    // Display the output response (Monitor signals)
    initial begin
        $monitor("Time: %0t | Timer: %d | Control Counter: %d", $time, timer, control_counter);
    end

endmodule