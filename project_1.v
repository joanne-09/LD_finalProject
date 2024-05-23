`timescale 1ns/1ps

module Functional_Unit(instruction, A, B, C, select, F);
    input wire [7:0] instruction;
    input wire [7:0] A;
    input wire [7:0] B;
    input wire [7:0] C;
    input wire [2:0] select;
    output [7:0] F;
    reg [7:0] X, Y;
    wire [2:0] encoder_instruction;

    encoder e1(instruction,encoder_instruction);


    //TODO: write your design below
    //You can define F as 'reg' or 'wire'
    //You must only use "encoder_instructions", not "instruction".

endmodule

module encoder (instruction,encoder_instruction);

    input wire[7:0] instruction;
    output [3:0] encoder_instruction;

    //TODO: write your design below
    //You can define encoder_instruction as 'reg' or 'wire'

endmodule