`timescale 1ns/1ps
module find_MAX(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire valid,
    input wire [7:0] data_A,
    input wire [7:0] data_B,
    input wire [7:0] data_C,
    input wire [7:0] instruction,
    input wire [2:0] count,
    input wire [2:0] select,
    output reg [7:0] second_maximum
);
    wire [7:0] result;

    // Functional_Unit instantiation
    Functional_Unit fu(
        .instruction(instruction), 
        .A(data_A),
        .B(data_B),
        .C(data_C),
        .select(select),
        .F(result)
    );
    //TODO: write your design below
    //You cannot modify anything above
    reg [7:0] maximum;
    reg started;
    reg [2:0] cnt;

    always @(posedge clk) begin
        if(rst_n == 0) begin
            started = 0;
            maximum <= 8'd0;
            second_maximum <= 8'd0;
        end
        else if(start == 1) begin
            started = 1;
            cnt = count;
        end
        else if(valid == 1 && started) begin
            cnt = cnt - 3'b001;
            if(result > maximum) begin
                second_maximum = maximum;
                maximum = result;
            end
            else if(result > second_maximum) begin
                second_maximum = result;
            end

            if(cnt == 3'b000) begin
                started = 0;
            end
        end
    end
endmodule

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

    reg [7:0] F;

    always @(*) begin
        //$display("encoder: 3'b%b", encoder_instruction);

        case(select)
            3'b011:
            begin
                X = B;
                Y = C;
            end
            3'b101:
            begin
                X = A;
                Y = C;
            end
            3'b110:
            begin
                X = A; Y = B;
            end
            default:
            begin
                X = C;
                Y = A;
            end
        endcase

        case (encoder_instruction)
            3'b111 : 
            begin
                if(X[7] == 1) 
                    F = (X<<1) + Y + 8'b00000001;
                else 
                    F = (X<<1) + Y;
            end
            3'b110 : 
            begin
                if(X[0] == 1)
                    F = 8'b10000000 + (X>>1) + Y;
                else
                    F = (X>>1) + Y;
            end
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
            3'b001 : F = X + (~Y);
            3'b000 : F = X + Y;
            default : F = X + Y;
        endcase
    end
endmodule

module encoder(instruction, encoder_instruction);
    input wire[7:0] instruction;
    output [3:0] encoder_instruction;

    reg [3:0] encoder_instruction;
    always @(instruction) begin
        casez (instruction)
            8'b1??????? : encoder_instruction = 4'b0111;
            8'b01?????? : encoder_instruction = 4'b0110;
            8'b001????? : encoder_instruction = 4'b0101;
            8'b0001???? : encoder_instruction = 4'b0100;
            8'b00001??? : encoder_instruction = 4'b0011;
            8'b000001?? : encoder_instruction = 4'b0010;
            8'b0000001? : encoder_instruction = 4'b0001;
            8'b00000001 : encoder_instruction = 4'b0000;
            default : encoder_instruction = 4'b0000;
        endcase
    end
endmodule