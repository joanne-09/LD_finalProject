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

    always @(encoder_instruction or select) begin
        if(select == 3'b011)
            begin
                X = B;
                Y = C;
            end
        else if(select == 3'b101)
            begin
                X = A;
                Y = C;
            end
        else if(select == 3'b110)
            begin
                X = A;
                Y = B;
            end
        else
            begin
                X = C;
                Y = A;
            end

        case (encoder_instruction)
            3'b111 : F = X<<1 + Y;
            3'b110 : F = X>>1 + Y;
            3'b101 : 
            begin
                if(X < Y)
                    F = X;
                else
                    F = Y;
            end
            3'b100 : 
            begin
                if(X > Y)
                    F = X;
                else
                    F = Y;
            end
            3'b011 : F = X | Y;
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