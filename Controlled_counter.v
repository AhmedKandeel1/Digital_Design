`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2025 03:52:54 PM
// Design Name: 
// Module Name: Controlled_counter
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


module Controlled_counter(

    input clk,
    input reset,         
    output reg [3:0] timer,  // Timer from 9 to 0
    output reg [6:0] control_counter // Control counter from 0 to 100
);

    // Control Counter: Counts from 0 to 50
    always @(posedge clk or posedge reset)
     begin
        if (reset) 
            control_counter <= 0;
        else 
            control_counter <= (control_counter == 50) ? 0: (control_counter + 1);
    end

    // Timer: Decrements when control_counter reaches 100
    always @(posedge clk or posedge reset) begin
        if (reset) 
            timer <= 9; // Start timer at 9
        else 
            timer <= (control_counter == 50 && timer > 0) ? timer - 1:timer; // Decrement timer
    end




//    // FSM States
//    localparam IDLE = 0 ; 
//    localparam COUNTING = 1 ; 
//    localparam DECREMENT = 2 ; 
//    localparam DONE = 3 ; 
//    reg [1:0] state, next_state;
    
//// Sequential logic for state transitions
//always @(posedge clk or posedge reset) begin
//    if (reset) begin
//        state <= IDLE;  // Reset state to IDLE
//    end else begin
//        state <= next_state;
//    end
//end

//    // State transition logic
//    always @(*) begin
//        case (state)
//            IDLE: 
//                next_state = (reset) ? IDLE : COUNTING;
            
//            COUNTING: 
//                next_state = (control_counter == 7'd49) ? DECREMENT : COUNTING;
            
//            DECREMENT: 
//                next_state = (timer == 4'd0) ? DONE : COUNTING;
            
//            DONE: 
//                next_state = (reset) ? IDLE : DONE;
            
//            default: 
//                next_state = IDLE;
//        endcase
//    end


//// Separate sequential logic for timer and control counter
//always @(posedge clk or posedge reset) begin
//    if (reset) begin
//        timer = 4'd9;            // Start timer from 9
//        control_counter = 7'd0;  // Reset control counter
//    end else begin
//        case (state)
//            COUNTING: 
//                control_counter = control_counter + 1'b1;

//            DECREMENT: begin
//                timer = timer - 1'b1;
//                control_counter = 7'd0; // Reset control counter
//            end

//            DONE: begin
//                timer = 4'd0;  // Keep timer at 0
//                control_counter = 7'd0;
//            end
//        endcase
//    end
//end

endmodule