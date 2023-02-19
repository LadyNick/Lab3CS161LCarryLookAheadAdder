//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Nicole Navarro 
// Email: nnava026@ucr.edu
// 
// Assignment name: Lab 3 Carry Look Ahead Adder
// Lab section: 021
// TA: Jincong Lu
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

//  Constant definitions 

module carry_look_ahead_adder # ( parameter NUMBITS = 16 ) (
  input  wire[NUMBITS-1:0] A, 
  input  wire[NUMBITS-1:0] B, 
  input wire carryin, 
  output reg [NUMBITS-1:0] result,  
  output reg carryout
);

  // ------------------------------
  // Insert your solution below
  // ------------------------------ 

  output wire[NUMBITS-1:0] result_carrylookahead;
  output wire[NUMBITS-1:0] carryout_carrylookahead;
  output wire[NUMBITS-1:0] g_carrylookahead;
  output wire[NUMBITS-1:0] p_carrylookahead;
  output wire[NUMBITS:0] carryin_carrylookahead;

  //G is A AND B
  //P is A XOR B

  always @(*) begin
    result <= result_carrylookahead;
    carryout <= carryout_carrylookahead[NUMBITS-1];
  end

  spg_block #() firstadder(  .a(A[0]),
                            .b(B[0]),
                            .c_in(carryin),
                            .s(result_carrylookahead[0]),
                            .g(g_carrylookahead[0]),
                            .p(p_carrylookahead[0]));
  
  genvar i;
  generate
    for(i=1; i<NUMBITS; i = i+1)begin
      spg_block #() firstadder(  .a(A[i]),
                            .b(B[i]),
                            .c_in(carryout_carrylookahead[i-1]),
                            .s(result_carrylookahead[i]),
                            .g(g_carrylookahead[i]),
                            .p(p_carrylookahead[i]));
    end
  endgenerate 

  carry_look_ahead_logic #(.NUMBITS(NUMBITS)) carrylookwirelogic( .p(p_carrylookahead),
                                                                  .g(g_carrylookahead),
                                                                  .c_in(carryin),
                                                                  .c(carryin_carrylookahead));


endmodule