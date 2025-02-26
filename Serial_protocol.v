`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/15/2025 10:22:32 AM
// Design Name: 
// Module Name: Serial_protocol
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


module Serial_protocol(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); 
//    // Use FSM from Fsm_serial
//    reg [3:0] state_reg, next_state ; 
//    reg [7:0] serial_in_reg ; 
//    localparam idle = 0 ; 
//    localparam start = 1;
//    localparam B0 = 2 ; 
//    localparam B1 = 3 ; 
//    localparam B2 = 4 ; 
//    localparam B3 = 5 ; 
//    localparam B4 = 6 ; 
//    localparam B5 = 7 ; 
//    localparam B6 = 8 ; 
//    localparam B7 = 9 ; 
//    localparam stop = 10 ; 
//    localparam DONE = 11 ; 
//    localparam WAIT_FOR_STOP = 12 ; 

//    // State flip-flops (sequential)
//    always @(posedge clk) 
//        begin
//            if (reset) 
//                begin 
//                state_reg <= idle ; 
//            	serial_in_reg <= 8'bx ; 
//                end 
//            else 
//                begin 
//                	state_reg <= next_state ; 
//                     // take in the data between these two sataes 
//                     // make sure to give the states numbers matching the order in the case statement 
//                     // we start data LSB in the "Start" state, why not B0 ? GOOD question :) 
//                      // as we are in the start state, the next input will move us to B0, this input is actually the first data bit, so we have to take it 
//                    if (state_reg >= start && state_reg <= B6) 
//                        begin 
//                            serial_in_reg <= {in,serial_in_reg[7:1]} ;
//                        end 
//                end 

//        end 
    
    
//    /// we can also manually assign the data of each state 
////    always @(*)
////        begin 
////            next_state = state_reg ; 
////            case (state_reg) 
////                idle: next_state = in == 0 ? start: idle ;
////                start: begin next_state = B0 ; serial_in_reg [0] = in ; end
////                B0: begin next_state = B1 ;  serial_in_reg [1] = in ; end 
////                B1: begin next_state = B2 ; serial_in_reg [2] = in ; end
////                B2: begin next_state = B3 ;  serial_in_reg [3] = in ; end
////                B3: begin next_state = B4 ;   serial_in_reg [4] = in ; end
////                B4: begin next_state = B5 ;  serial_in_reg [5] = in ; end
////                B5: begin next_state = B6 ; serial_in_reg [6] = in ; end
////                B6: begin next_state = B7 ;  serial_in_reg [7] = in ; end
////                B7:  next_state = in == 1 ? DONE: WAIT_FOR_STOP;  
////                WAIT_FOR_STOP: next_state = in == 0 ? WAIT_FOR_STOP: idle ; 
////                DONE: next_state = in == 0 ? start: idle ; 
////                //                 stop: next_state =  DONE ; 

////            endcase 
            
////        end 
        
//            always @(*)
//    begin 
//        next_state = state_reg ; 
//        case (state_reg) 
//            idle: next_state = in == 0 ? start: idle ;
//            start: next_state = B0 ; 
//            B0: next_state = B1 ;  
//            B1: next_state = B2 ;
//            B2: next_state = B3 ; 
//            B3: next_state = B4 ;   
//            B4: next_state = B5 ; 
//            B5: next_state = B6 ;  
//            B6: next_state = B7 ; 
//            B7: next_state = in == 1 ? DONE: WAIT_FOR_STOP; 
//            WAIT_FOR_STOP: next_state = in == 0 ? WAIT_FOR_STOP: idle ; 
//            DONE: next_state = in == 0 ? start: idle ; 
//            //                 stop: next_state =  DONE ; 

//        endcase 
        
//    end 
 
//    // Output logic
//    assign done = (state_reg == DONE) ;

//    // New: Datapath to latch input bits.
//    assign out_byte = (state_reg == DONE)? serial_in_reg: 8'bx ;

//endmodule


    
    // Use FSM from Fsm_serial
    reg [1:0] state_reg, next_state ; 
    reg [7:0] serial_in_reg ; 
    localparam idle = 0 ; 
    localparam RECIEVE = 1;
    localparam DONE = 2 ; 
    localparam ERROR = 3 ; 
	
    integer counter ; 
    // State flip-flops (sequential)
    always @(posedge clk) 
        begin
            if (reset) 
                begin 
                state_reg <= idle ; 
            	serial_in_reg <= 8'bx ; 
                counter = 0 ;  // NOTICe that counter should be blocking assignment 
                end 
            else 
                begin 
                	state_reg <= next_state ; 
                    if (next_state == RECIEVE) 
                            begin 
                                counter = counter +1 ;// NOTICe that counter should be blocking assignment 
                                if (counter > 1)
                                    serial_in_reg <= {in,serial_in_reg[7:1]} ;
                            end 
                    else  // this else means >> if ~(next_state == RECIEV) if u are not in recieve state, reset the counter
                        counter = 0 ; // NOTICe that counter should be blocking assignment 
                end 

        end 
        
            always @(*)
    begin 
        next_state = state_reg ; 
        case (state_reg) 
            idle: next_state = in == 0 ? RECIEVE: idle ;
            RECIEVE: next_state = (counter == 9 && in ) ? DONE :(counter == 9 && ~in)? ERROR:RECIEVE; 
            ERROR: next_state = in == 0 ? ERROR: idle ; 
            DONE: next_state = in == 0 ? RECIEVE: idle ; 

        endcase 
        
    end 
 
    // Output logic
    assign done = (state_reg == DONE) ;

    // New: Datapath to latch input bits.
    assign out_byte = (state_reg == DONE)? serial_in_reg: 8'bx ;

endmodule



