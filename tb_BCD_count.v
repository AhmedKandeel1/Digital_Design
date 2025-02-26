`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/12/2025 10:29:51 PM
// Design Name: 
// Module Name: tb_BCD_count
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


module tb_BCD_count(

    );
    // Testbench signals
    reg clk;
    reg reset;
    reg enable;
    wire [3:0] Q;

    // Instantiate BCD Counter
    BCD_count uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .Q(Q)
    );

    // Generate Clock: Period = 10ns (100MHz)
    always #5 clk = ~clk;  

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        enable = 0;
        
        // Apply reset
        #10 reset = 0;
        enable = 1;  // Start counting

        // Run for a few cycles (checking full 0 → 9 cycle)
        #10 enable = 0;  // Pause counting
        #20 reset = 1;     // Apply reset
        #10 reset = 0;
        #100 enable = 1 ; 
        #300;  // Additional time

        // Stop simulation
        $finish;
    end

        initial begin
        $dumpfile("tb_BCD_count.vcd");
        $dumpvars(0, tb_BCD_count);

        $display("Time\tQ");
        $monitor("%0t\t%d", $time, Q);
    end
endmodule
