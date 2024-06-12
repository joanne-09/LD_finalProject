`timescale 1ns/1ps
`define DELAY 10
`define NUM_OF_PAT 256

module tb;
    reg [7:0] A;
    reg [7:0] B;
    reg [7:0] C;
    reg [7:0] instruction;
    reg [2:0] select;
    wire [7:0] F;

    // Module instantiation
    Functional_Unit fu(
        .instruction(instruction), 
        .A(A),
        .B(B),
        .C(C),
        .select(select),
        .F(F)
    );

    // load patterns
    reg [7:0] patterns [0:2047];
    reg [7:0] golden [0:511];
    reg [7:0] instruct [0:511];
    reg [2:0] selection [0:511];
    
    initial begin
        $readmemh("./data/pattern", patterns);
        $readmemh("./data/golden1", golden);
        $readmemh("./data/instruction", instruct);
        $readmemb("./data/selection", selection);
    end
    
    initial begin
        A = 8'dx;
        B = 8'dx;
        C = 8'dx;
        select = 3'dx;
        instruction = 8'dx;
    end

    integer i;
    initial begin
        for(i = 0; i < `NUM_OF_PAT; i = i + 1) begin
            #(`DELAY);
            A = patterns[i * 3];
            B = patterns[i * 3 + 1];
            C = patterns[i * 3 + 2];
            select = selection[i];
            instruction = instruct[i];
        end
    end
    
    integer j, error;
    initial begin
        error = 0;
        #(`DELAY/2);
        for(j = 0; j < `NUM_OF_PAT; j = j + 1) begin
            #(`DELAY);
            if(golden[j]!==F) begin
                error = error + 1;
                $display("\n-------------------------------------------------------");
                $display("[ERROR]");
                $display("testcase %3d",j + 1);
                $display("A = 8'b%b (8'h%h) ", A, A);
                $display("B = 8'b%b (8'h%h) ", B, B);
                $display("C = 8'b%b (8'h%h) ", C, C);
                $display("select = 3'b%b ", selection[j]);
                $display("instruction = 8'b%b (8'h%h)", instruct[j] ,instruct[j]);
                $display("Your answer = 8'b%b (8'h%h), but the golden = 8'b%b (8'h%h)", F, F, golden[j], golden[j]);
                $display("-------------------------------------------------------\n");
            end
            /*else begin
                $display("\n-------------------------------------------------------");
                $display("[CORRECT]");
                $display("testcase %3d",j + 1);
                $display("A = 8'b%b (8'h%h) ", A, A);
                $display("B = 8'b%b (8'h%h) ", B, B);
                $display("C = 8'b%b (8'h%h) ", C, C);
                $display("select = 3'b%b ", selection[j]);
                $display("instruction = 8'b%b (8'h%h)", instruct[j] ,instruct[j]);
                $display("Your answer = 8'b%b (8'h%h), but the golden = 8'b%b (8'h%h)", F, F, golden[j], golden[j]);
                $display("-------------------------------------------------------\n");
            end*/
        end
        if(error==0) begin
            $display("\n[success] You can start doing problem 2.\n");
        end else begin
            $display("\n[FAIL] There are %3d errors.\n", error);
        end
        $finish;
    end
endmodule