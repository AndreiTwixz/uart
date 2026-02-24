`timescale 1ns / 1ps

module top(
    input logic clk,
    input logic rst,
    input logic start,
    input logic [7:0] data_in,
    output logic out_tx
);

    logic out_tff;
    logic [19:0] baud_val;
    logic [3:0] bit_val;
    logic baud_limit;
    logic bit_limit;
    logic parity;
    logic [10:0] frame;
    logic [10:0] reg_data;
    logic mux_out;
    logic toggle_signal;

    assign baud_limit = (baud_val == 20'd10416);
    assign bit_limit = (bit_val == 4'd10);
    assign toggle_signal = (start & ~out_tff) | (baud_limit & bit_limit);

    toggle_ff tff_inst (
        .clk(clk),
        .rst(rst),
        .toggle(toggle_signal),
        .out(out_tff)
    );

    counter_baud_rate cbr_inst (
        .clk(clk),
        .rst_async(rst),
        .rst_sync(baud_limit | start),
        .en(out_tff),
        .out(baud_val)
    );

    counter_bit_select cbs_inst (
        .clk(clk),
        .rst(rst | start),
        .en(out_tff & baud_limit),
        .out(bit_val)
    );

    crc_calc crc_inst (
        .in(data_in),
        .out(parity)
    );

    assign frame = {1'b1, parity, data_in, 1'b0};

    reg0 reg_inst (
        .clk(clk),
        .rst(rst),
        .load(start),
        .data_in(frame),
        .data_out(reg_data)
    );

    mux mux_inst (
        .in(reg_data),
        .sel(bit_val),
        .out(mux_out)
    );

    assign out_tx = out_tff ? mux_out : 1'b1;

endmodule