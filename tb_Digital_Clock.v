`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 09:38:52 PM
// Design Name: 
// Module Name: tb_Digital_Clock
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


module tb_Digital_Clock (
    );

    // Inputs
    reg clk;
    reg reset;
    reg ena;

    // Outputs
    wire [7:0] hh;
    wire [7:0] mm;
    wire [7:0] ss;
    wire pm;

Digital_Clock uut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .pm(pm),
    .hh(hh),
    .mm(mm),
    .ss(ss)
);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units (10ns period)
    end

    // Test procedure
    initial begin
        // Initialize inputs
        reset = 1;
        ena = 0;
        #20; // Wait for 20ns

        // Release reset and enable the clock
        reset = 0;
        ena = 1;

        // Let the clock run for a while
        #100000; // Simulate for 100,000ns (100us)

        // Disable the clock
        ena = 0;
        #100; // Wait for 100ns

        // Re-enable the clock
        ena = 1;
        #50000; // Simulate for another 50,000ns (50us)

        // Apply reset again
        reset = 1;
        #20; // Wait for 20ns
        reset = 0;

        // Let the clock run for a while longer
        #2000000; // Simulate for 200,000ns (200us)

        // End simulation
        $stop;
    end


endmodule
