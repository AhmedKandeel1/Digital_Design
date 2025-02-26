`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 02:04:43 PM
// Design Name: 
// Module Name: tb_Complex_timer
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


module tb_Complex_timer();
   reg clk;
    reg reset;
    reg data;
    reg ack;
    wire [3:0] count;
    wire counting;
    wire done;
    
    // Instantiate the Complex_timer module
    Complex_timer uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .ack(ack),
        .count(count),
        .counting(counting),
        .done(done)
    );
    
    // Generate clock signal
    always #5 clk = ~clk; // 10ns clock period
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        data = 0;
        ack = 0;
        
        // Apply reset
        #20 reset = 0;
        
        // Send start sequence 1101
        #10 data = 1;
        #10 data = 1;
        #10 data = 0;
        #10 data = 1;
        
        // Send delay value (example: 4'b0011 -> 3+1=4 thousand cycles)
        #10 data = 1;
        #10 data = 1;
        #10 data = 0;
        #10 data = 0;
        
        // Wait for counting to finish
        wait (done);
        
        // Assert ack to reset FSM
        #50 ack = 0;
        #10 ack = 1;
        
                // Send start sequence 1101
        #10 data = 1;
        #10 data = 1;
        #10 data = 0;
        #10 data = 1;
        
        // Send delay value (example: 4'b0011 -> 3+1=4 thousand cycles)
        #10 data = 0;
        #10 data = 1;
        #10 data = 0;
        #10 data = 0;
        
        // Add more test cases as needed
        #38000 $finish;
    end
    
endmodule
