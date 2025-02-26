`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 11:18:28 PM
// Design Name: 
// Module Name: Frequency_divider_tb
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


module Frequency_divider_tb(

    );
// Testbench signals
    reg clk;
    reg reset;
    wire OneHertz;
    wire [3:0] Q1,Q2,Q3 ;
    wire [2:0] c_enable;

    // Instantiate the Frequency_divider module
    Frequency_divider dut (
        .clk(clk),
        .reset(reset),
        .OneHertz(OneHertz),
        .Q0(Q1), 
        .Q1(Q2), 
        .Q2(Q3), 
        .c_enable(c_enable)
    );

    // Clock generation: 10 ns period (100 MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Apply reset for 20 ns
        reset = 1;
        #20;
        reset = 0;
        
        // Let the simulation run for a while to see multiple counter rollovers.
        #20000;
        $finish;
    end

    // Dump waveforms and monitor key signals
//    initial begin
//        $dumpfile("Frequency_divider_tb.vcd");
//        $dumpvars(0, Frequency_divider_tb);
//        $monitor("Time = %0t | OneHertz = %b | c_enable = %b", $time, OneHertz, c_enable);
//    end

endmodule
