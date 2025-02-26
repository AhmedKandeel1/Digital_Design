`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2025 09:28:31 PM
// Design Name: 
// Module Name: Serial_protocol_with_Parity
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


module Serial_protocol_with_Parity(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //


// Use FSM from Fsm_serial
    reg [2:0] state_reg, next_state ; 
    reg [8:0] serial_in_reg ; 
    
    localparam idle = 0 ; 
    localparam RECIEVE = 1;
    localparam PARITY_DONE = 2 ;
    localparam DONE =3 ; 
    localparam ERROR = 4 ; 
	
    integer counter ; 
    wire odd ; 
    parity A1 (.clk(clk), .reset(~(state_reg == RECIEVE)) , .in(in) , .odd(odd) ) ;
    
    // State flip-flops (sequential)
    always @(posedge clk) 
        begin
            if (reset) 
                begin 
                state_reg <= idle ; 
            	serial_in_reg <= 8'bx ; 
                    counter = 0 ; 
                end 
            else 
                begin 
                	state_reg <= next_state ; 
                    if (next_state == RECIEVE) 
                        begin 
                            counter = counter +1 ;
                            if (counter > 1)
                            	serial_in_reg <= {in,serial_in_reg[7:1]} ;
                        end 
                    if (~(next_state == RECIEVE)) 
                        counter = 0 ; 
                end 

        end 
        
        
    always @(*)
    begin 
        case (state_reg) 
            idle: next_state = in == 0 ? RECIEVE: idle ;
            RECIEVE: next_state = (counter == 9 && (in== ~odd)) ? PARITY_DONE : (counter == 9 && (in ==odd) ) ? ERROR:RECIEVE; 
            PARITY_DONE: next_state = in == 1 ? DONE: ERROR ; 
            ERROR: next_state = in == 1 ? idle: ERROR ; 
            DONE: next_state = in == 1 ? idle: RECIEVE ; 
        endcase 
        
    end 
 
    // Output logic
    assign done = (state_reg == DONE ) ;

    // New: Datapath to latch input bits.
    assign out_byte = (state_reg == DONE)? serial_in_reg: 8'bx ;

endmodule
