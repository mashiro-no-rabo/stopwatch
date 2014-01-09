`timescale 1ns / 1ps
module register24(
	input wire clk,
	input wire[23:0] data_in,
	output reg[23:0] data_out);
	always @(posedge clk)
		data_out <= data_in;
endmodule
