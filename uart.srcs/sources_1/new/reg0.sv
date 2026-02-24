`timescale 1ns / 1ps

module reg0(
    input logic clk,
    input logic rst,
    input logic load,
    input logic [10:0] data_in,
    output logic [10:0] data_out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 11'b11111111111;
        else if (load)
            data_out <= data_in;
    end

endmodule