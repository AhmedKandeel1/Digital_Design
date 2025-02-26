`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2025 09:42:47 AM
// Design Name: 
// Module Name: FSM_Q3a
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


module FSM_Q3a(
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    reg  state_reg, next_state ;  
        localparam A = 0 ; 
    localparam B = 1;
        always @(posedge clk) 
        begin 
        if (reset) 
            state_reg <= A ;
            else 
                state_reg <= next_state ; 
        end 
    
        

    
        always @(*)
        begin 
            case (state_reg) 
               A:  next_state = s ? B: A ; 
                B:  next_state = B; 
            endcase 
        end 
    
    integer cycle_counter ; 
    reg [1:0] w_counter ; 
    
    always @(posedge clk) 
        begin 
            if (reset || state_reg == A ) 
                begin 
            cycle_counter = 0 ; 
            w_counter = 0 ;
                end 
    	else 
            begin 
                if (state_reg == B)
                    begin 
                        if ( cycle_counter < 3)                               
                                cycle_counter = cycle_counter + 1 ;                             
                        else 
                            begin 
                           		 cycle_counter = 1 ; w_counter = 0;                                 
                            end 
                    end 
                if (next_state == B)      
                    begin 
                        w_counter = w_counter + w ;      
                    end 
            end 
        end 
    assign z = (cycle_counter == 3) && ( w_counter == 2'd2)    ;	
endmodule
