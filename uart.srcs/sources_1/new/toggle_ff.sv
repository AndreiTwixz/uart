`timescale 1ns / 1ps

module toggle_ff(
    input logic clk,
    input logic rst,
    input logic toggle,
    output logic out
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            out <= 1'b0;
        else if (toggle)
            out <= ~out;
    end

endmodule