`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2025 08:50:11 AM
// Design Name: 
// Module Name: Packet_parser
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


module Packet_parser(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    
    reg [1:0] state_reg, next_state ; 
    reg [23:0] Datapath ; 
    localparam s0 = 0 ; 
    localparam s1 = 1 ; 
    localparam s2 = 2 ; 
    localparam s3 = 3 ; 

    // State flip-flops (sequential)
    always @(posedge clk) 
        begin
            if (reset) 
                state_reg <= s0 ; 
            else 
                state_reg <= next_state ; 
           		Datapath <= {Datapath[15:0],in} ; 
        end 
    
    // State transition logic (combinational)
    always @(*)
        begin 
            case (state_reg) 
                s0: next_state = in[3] == 1 ? s1: s0 ; 
                s1: next_state = s2 ; 
                s2: next_state = s3 ; 
                s3: next_state = in[3] == 1 ? s1: s0 ;  
            endcase 
            
        end 
 
    // Output logic
    assign done = state_reg == s3 ;
        assign out_bytes = Datapath ; 


endmodule

