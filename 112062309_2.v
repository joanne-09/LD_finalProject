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
    reg [7:0] max, sec_max;
    reg started;
    reg [2:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if(rst_n == 0) begin
            started = 0;
            max <= 8'd0;
            sec_max <= 8'd0;
        end
        else if(start == 1) begin
            started = 1;
            cnt = count;
        end
        else if(cnt == 3'b000 && started) begin
            started <= 0;
            second_maximum <= sec_max;
            max <= 8'd0;
            sec_max <= 8'd0;
        end
        else if(valid && started) begin
            cnt = cnt - 3'b001;
            if(result > max) begin
                sec_max <= max;
                max <= result;
            end
            else if(result > sec_max) begin
                sec_max = result;
            end
            else ;
        end
        else ;
    end
endmodule
