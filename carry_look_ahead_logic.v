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

module carry_look_ahead_logic # (parameter NUMBITS = 4) (
    input  wire [NUMBITS-1:0] p, 
    input  wire [NUMBITS-1:0] g,
    input  wire c_in,
    output reg  [NUMBITS:0] c

);
    // ------------------------------
    // Insert your solution below
    // ------------------------------ 

    wire [NUMBITS-1:0] c_w;
    assign c_w[0] = c_in;

    always @(*)begin
        c <= c_w;
    end

    wire [NUMBITS-1:0] prevmath;
    assign prevmath[0] = c_in;

    genvar i,j;
    generate
        for(i=1; i<NUMBITS; i=i+1)begin
            wire[i-1:0] stage_ors;
            for(j=0; j<i; j=j+1)begin
                slow_and #() andsol(.a({p[i-1],prevmath[j]}),.result(stage_ors[j]));
            end
            slow_or #(.NUMINPUTS(i+1)) csol(.a({g[i],stage_ors}), .result(c_w[i]));
            assign prevmath = {g[i],stage_ors};
        end
    endgenerate
    


endmodule