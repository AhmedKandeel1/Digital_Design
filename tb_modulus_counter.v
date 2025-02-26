`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 10:06:59 PM
// Design Name: 
// Module Name: tb_modulus_counter
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


module tb_modulus_counter ();

    reg clk, reset, enable;
    wire [3:0] Q;
  // Instantiate the BCD counter
    BCD_count uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10-time-unit clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        reset = 1;
        enable = 0;
        #10;

        // Release reset
        reset = 0;
        enable = 1;
        #100; // Let the counter run for 100 time units

        // Disable the counter
        enable = 0;
        #20;

        // Re-enable the counter
        enable = 1;
        #50;

        // End simulation
        $stop;
    end
endmodule
