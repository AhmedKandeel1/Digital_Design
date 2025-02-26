`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2025 10:45:13 PM
// Design Name: 
// Module Name: Multi_seq_detector_moore
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
/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns 
that indicate the beginning and end of frames (packets). Seeing exactly 6 consecutive 1s (i.e., 01111110) is a "flag" 
that indicate frame boundaries. To avoid the data stream from accidentally containing "flags", 
the sender inserts a zero after every 5 consecutive 1s which the receiver must detect and discard.
 We also need to signal an error if there are 7 or more consecutive 1s.


Create a finite state machine to recognize these three sequences:

0111110: Signal a bit needs to be discarded (disc).
01111110: Flag the beginning/end of a frame (flag).
01111111...: Error (7 or more 1s) (err).
When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

Here are some example sequences that illustrate the desired operation.
*/ 

module Multi_seq_detector_moore(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    assign err = (state_reg == ERROR ) ; 
    assign flag = (state_reg == FLAG ) ; 
    assign disc = (state_reg == DISCARD ) ; 

    reg [3:0] state_reg, next_state ; 
    localparam idle = 0 ; 
    localparam ONE = 1;
    localparam TWO = 2 ; 
    localparam THREE = 3 ; 
    localparam FOUR = 4 ; 
    localparam FIVE = 5 ; 
    localparam DISCARD = 6 ; 
    localparam SIX = 7 ; 
    localparam FLAG = 8 ; 
    localparam ERROR = 9 ; 
    
    always @(posedge clk) 
        begin
            if (reset)                  
                state_reg <= idle ;                 
            else                
                	state_reg <= next_state ;                 
        end 
    
    always @(*)
    begin 
        case (state_reg) 
            idle: next_state = in == 1 ? ONE: idle ;
            ONE: next_state = in == 1 ? TWO: idle ; 
            TWO: next_state = in == 1 ? THREE: idle ;
            THREE:  next_state = in == 1 ? FOUR: idle ;
            FOUR:  next_state = in == 1 ? FIVE: idle ;
            FIVE: next_state = in == 1 ? SIX: DISCARD ;
            DISCARD: next_state = in == 1 ? ONE: idle ;
            SIX: next_state = in == 1 ? ERROR: FLAG ;
            FLAG: next_state = in == 1 ? ONE: idle ;
            ERROR: next_state = in == 1 ? ERROR: idle; 
            default: next_state = idle ; 
        endcase        
    end 
    
endmodule