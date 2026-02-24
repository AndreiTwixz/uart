`timescale 1ns / 1ps

module tb_top();

    logic clk;
    logic rst;
    logic start;
    logic [7:0] data_in;
    logic out_tx;

    top dut (.*);

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        data_in = 8'd254;
        #100 rst = 0;
        #30 start = 1;
        #10 start = 0;
        #1500000;
        $finish;
    end

endmodule