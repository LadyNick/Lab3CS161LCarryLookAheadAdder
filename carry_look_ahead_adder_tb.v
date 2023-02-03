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

module carry_look_ahead_adder_tb;
    parameter NUMBITS = 4;

    // Inputs
    reg clk;
    reg reset;
    reg [NUMBITS-1:0] A;
    reg [NUMBITS-1:0] B;
    
    // Outputs
    wire [NUMBITS-1:0] result;
    reg [NUMBITS-1:0] expected_result;
    wire carryout;
    

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab03.vcd");
        $dumpvars(0);
    end

    // -------------------------------------------------------
    // Instantiate the Unit Under Test (UUT)
    // -------------------------------------------------------
    carry_look_ahead_adder #(.NUMBITS(NUMBITS)) uut (
        .A(A), 
        .B(B), 
        .carryin(1'b0),
        .result(result), 
        .carryout(carryout)
    );

    //-----------------------------------------------------------
    //Testing for more bits
    reg[15:0] A_16;
    reg[15:0] B_16;
    wire [15:0] result_16;
    reg [15:0] expected_result_16;
    wire carryout_16;

    reg[31:0] A_32;
    reg[31:0] B_32;
    wire [31:0] result_32;
    reg [31:0] expected_result_32;
    wire carryout_32;

    reg[63:0] A_64;
    reg[63:0] B_64;
    wire [63:0] result_64;
    reg [63:0] expected_result_64;
    wire carryout_64;

    reg[127:0] A_128;
    reg[127:0] B_128;
    wire [127:0] result_128;
    reg [127:0] expected_result_128;
    wire carryout_128;

    carry_look_ahead_adder #(.NUMBITS(16)) BitAdder16( .A(A_16),
                                            .B(B_16),
                                            .carryin(1'b0),
                                            .result(result_16),
                                            .carryout(carryout_16));
    carry_look_ahead_adder #(.NUMBITS(32)) BitAdder32( .A(A_32),
                                            .B(B_32),
                                            .carryin(1'b0),
                                            .result(result_32),
                                            .carryout(carryout_32));
    carry_look_ahead_adder #(.NUMBITS(64)) BitAdder64( .A(A_64),
                                            .B(B_64),
                                            .carryin(1'b0),
                                            .result(result_64),
                                            .carryout(carryout_64));
    carry_look_ahead_adder #(.NUMBITS(128)) BitAdder128( .A(A_128),
                                            .B(B_128),
                                            .carryin(1'b0),
                                            .result(result_128),
                                            .carryout(carryout_128)); 
    //----------------------------------------------------------------


  
    initial begin 
    
        clk = 0; reset = 1; #50; 
        clk = 1; reset = 1; #50; 
        clk = 0; reset = 0; #50; 
        clk = 1; reset = 0; #50; 
         
        forever begin 
            clk = ~clk; #50; 
        end 
    end 
    
    integer totalTests = 0;
    integer failedTests = 0;
    
    initial begin // Test suite
        // Reset
        @(negedge reset); // Wait for reset to be released (from another initial block)
        @(posedge clk);   // Wait for first clock out of reset 
        #10; // Wait 10 cycles 

        // Additional test cases
        // ---------------------------------------------
        // Testing unsigned additions 
        // --------------------------------------------- 
        $write("Test Group 1: Addition Behavior Verification ... \n");

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.1:   0+  0 =   0, c_out = 0 ... ");
        A = 4'h0;
        B = 4'h0;
        expected_result = 4'h0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 
        
        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.2: 127+  1 = 128, c_out = 0 ... ");
        A = 4'h7;
        B = 4'h1;
        expected_result = 4'h8;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.3: 255+  1 =   0, c_out = 1 ... ");
        A = 4'hF;
        B = 4'h1;
        expected_result = 4'h0;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.4: 123+ 46 = 169, c_out = 0 ... ");
        A = 4'd12;
        B = 4'd2;
        expected_result = 4'd14;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b0) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        // Code necessary for each test case 
        totalTests = totalTests + 1;
        $write("\tTest Case 1.5: 123+146 =  13, c_out = 1 ... ");
        A = 4'd12;
        B = 4'd6;
        expected_result = 4'd2;

        #100; // Wait 
        if (expected_result !== result || carryout !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        //TESTS FROM RIPPLE CARRY ADDER LAB 2
        // ----------------------------------------
        // Tests group for Increasing Number of Bits 
        // ----------------------------------------
        $write("Test Group 2: Increasing Number of Bits ...\n");
        
        // ----------------------------------------
        // Add test cases here 
        // ----------------------------------------
        totalTests = totalTests + 1;
        //the result should be 0, with a carryout of 1
        $write("\tTest Case 2.1: 65535 + 1 = 65536, c_out = 1 ... ");
        A_16 = 16'hFFFF;
        B_16 = 16'h01;
        expected_result_16 = 16'h00;

        #100; // Wait 
        if (expected_result_16 !== result_16 || carryout_16 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        //the result should be 0, with a carryout of 1
        $write("\tTest Case 2.2: 4294967295 + 1 = 4294967296, c_out = 1 ... ");
        A_32 = 32'hFFFFFFFF;
        B_32 = 32'h01;
        expected_result_32 = 32'h00;

        #100; // Wait 
        if (expected_result_32 !== result_32 || carryout_32 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        //the result should be 0, with a carryout of 1
        $write("\tTest Case 2.3: 18446744073709551615 + 1 = 18446744073709551616, c_out = 1 ... ");
        A_64 = 64'hFFFFFFFFFFFFFFFF;
        B_64 = 64'h01;
        expected_result_64 = 64'h00;

        #100; // Wait 
        if (expected_result_64 !== result_64 || carryout_64 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 

        totalTests = totalTests + 1;
        //the result should be 0, with a carryout of 1
        $write("\tTest Case 2.4: 340282366920938463463374607431768211455 + 1 = 340282366920938463463374607431768211456, c_out = 1 ... ");
        A_128 = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        B_128 = 128'h01;
        expected_result_128 = 128'h00;

        #100; // Wait 
        if (expected_result_128 !== result_128 || carryout_128 !== 1'b1) begin
            $write("failed\n");
            failedTests = failedTests + 1;
        end else begin
            $write("passed\n");
        end
        #10; // Wait 


        // -------------------------------------------------------
        // End testing
        // -------------------------------------------------------
        $write("\n-------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests", totalTests-failedTests,totalTests);
        $write("\n-------------------------------------------------------\n");
        $finish;
    end
endmodule