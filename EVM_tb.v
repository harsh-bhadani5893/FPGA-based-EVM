`timescale 1ns / 1ps

module EVM_tb();
    reg clk,reset,mode;
    reg [3:0]candid_button;
    wire [3:0]vot_logged;
    wire valid_vote,invalid_vote;
    wire [7:0] display_out;
    EVM_v3 dut(.clk(clk),.reset(reset),.mode(mode),.candid_button(candid_button),.vot_logged(vot_logged),.valid_vote(valid_vote),.invalid_vote(invalid_vote),.display_out(display_out));
  
     initial begin
     #0 clk = 0;
     forever #5 clk = ~clk;
     end
     
     initial begin
     
     reset = 1;
     #20;
     reset = 0; mode =0;
     #20     candid_button = 4'b0001;
    
     #20     candid_button = 4'b0010;
     #20     candid_button = 4'b1000;
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0010;
     #20     candid_button = 4'b1000;
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0001;  
     
     #20     candid_button = 4'b0101;
     #20     candid_button = 4'b0001;
	  #20     candid_button = 4'b0010;
     #20     candid_button = 4'b0001;
     #20     candid_button = 4'b0101;
   
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b1000;
     
     #20     candid_button = 4'b0111;
    
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0001;
    
     #20  mode = 1;
     #20     candid_button = 4'b1001;
     #20     candid_button = 4'b1010;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0001;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0010;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b1000;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b1001;
     #20     candid_button = 4'b0000;
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b0100;
     #20     candid_button = 4'b1011;
     #20     candid_button = 4'b1111;
     #20     candid_button = 4'b0010;
     #40;

   // Finish simulation
     $finish;
     #40;

$finish;

     end
  
endmodule
