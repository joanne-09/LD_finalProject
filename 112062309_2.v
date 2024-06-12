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
    

endmodule