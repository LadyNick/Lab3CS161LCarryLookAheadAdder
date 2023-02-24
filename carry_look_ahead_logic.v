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

    wire [NUMBITS:0] c_w;
    assign c_w[0] = c_in;

    always @(*)begin
        c <= c_w;
    end

    genvar i,j;
    generate
        for(i=1; i<NUMBITS+1; i=i+1)begin
            wire[i-1:0] stage_ors;
            for(j=0; j<i; j=j+1)begin
                if (j==0) begin
                    slow_and #(.NUMINPUTS(i+1)) andc0(.a({p[i-1:0], c_in}), .result(stage_ors[j]));
                end
                else begin
                    slow_and #(.NUMINPUTS(i-j+1)) andsol(.a({p[i-1:j],g[j-1]}),.result(stage_ors[j]));
                end
            end
            slow_or #(.NUMINPUTS(i+1)) csol(.a({g[i-1],stage_ors}), .result(c_w[i]));
        end
    endgenerate

endmodule