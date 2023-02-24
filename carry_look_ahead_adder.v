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

  wire[NUMBITS-1:0] result_connect;
  wire[NUMBITS-1:0] carryout_connect;
  wire[NUMBITS-1:0] g_output;
  wire[NUMBITS-1:0] p_output;
  wire[NUMBITS:0] c_output;

  assign c_output[0] = carryin;

  always @(*) begin
    result <= result_connect;
    carryout <= c_output[NUMBITS];
  end

  spg_block #() firstadder(  .a(A[0]),
                            .b(B[0]),
                            .c_in(carryin),
                            .s(result_connect[0]),
                            .g(g_output[0]),
                            .p(p_output[0]));
  
  genvar i;
  generate
    for(i=1; i<NUMBITS; i = i+1)begin
      spg_block #() firstadder(  .a(A[i]),
                            .b(B[i]),
                            .c_in(c_output[i]),
                            .s(result_connect[i]),
                            .g(g_output[i]),
                            .p(p_output[i]));
    end
  endgenerate
  
  carry_look_ahead_logic #(.NUMBITS(NUMBITS)) carrylookwirelogic( .p(p_output),
                                                                  .g(g_output),
                                                                  .c_in(carryin),
                                                                  .c(c_output));


endmodule