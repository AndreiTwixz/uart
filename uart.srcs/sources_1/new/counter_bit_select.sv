`timescale 1ns / 1ps

module counter_bit_select(
    input logic clk,
    input logic rst,
    input logic en,
    output logic [3:0] out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            out <= 4'd0;
        else if (en)
            out <= out + 1;
    end

endmodule