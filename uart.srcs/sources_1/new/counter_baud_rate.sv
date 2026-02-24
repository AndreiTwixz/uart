`timescale 1ns / 1ps

module counter_baud_rate(
    input logic clk,
    input logic rst_async,
    input logic rst_sync,
    input logic en,
    output logic [19:0] out
);

    always_ff @(posedge clk or posedge rst_async) begin
        if (rst_async)
            out <= 20'd0;
        else if (rst_sync)
            out <= 20'd0;
        else if (en)
            out <= out + 1;
    end

endmodule