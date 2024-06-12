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
    reg [7:0] F;
    reg [7:0] max, min;
    always @(encoder_instruction) begin
        X = C; Y = A;
        case (encoder_instruction)
            3'b111 : F = X<<1 + Y;
            3'b110 : 
            begin
                X = A; Y = B;
                F = X>>1 + Y;
            end
            3'b101 : 
            begin
                X = A; Y = C;
                F = find_MIN(X, Y, min);
            end
            3'b100 : 
            begin
                F = find_MAX(X, Y, max);
            end
            3'b011 : 
            begin
                X = B; Y = C;
                F = X | Y;
            end
            3'b010 : F = X & Y;
            3'b001 : F = X + ~Y;
            3'b000 : F = X + Y;
            default : F = X + Y;
        endcase
    end
endmodule

module encoder (instruction,encoder_instruction);

    input wire[7:0] instruction;
    output [3:0] encoder_instruction;

    //TODO: write your design below
    //You can define encoder_instruction as 'reg' or 'wire'
    reg [3:0] encoder_instruction;
    always @(instruction) begin
        casex (instruction)
            8'b1xxxxxxx : encoder_instruction = 3'b111;
            8'b01xxxxxx : encoder_instruction = 3'b110;
            8'b001xxxxx : encoder_instruction = 3'b101;
            8'b0001xxxx : encoder_instruction = 3'b100;
            8'b00001xxx : encoder_instruction = 3'b011;
            8'b000001xx : encoder_instruction = 3'b010;
            8'b0000001x : encoder_instruction = 3'b001;
            8'b00000001 : encoder_instruction = 3'b000;
            default : encoder_instruction = 3'b000;
        endcase
    end
endmodule

module find_MAX(a, b, max);
    input wire [7:0] a;
    input wire [7:0] b;
    output [7:0] max;
    reg [7:0] max;
    always @(a, b) begin
        if (a > b) begin
            max = a;
        end else begin
            max = b;
        end
    end
endmodule

module find_MIN(a, b, min);
    input wire [7:0] a;
    input wire [7:0] b;
    output [7:0] min;
    reg [7:0] min;
    always @(a, b) begin
        if (a < b) begin
            min = a;
        end else begin
            min = b;
        end
    end
endmodule