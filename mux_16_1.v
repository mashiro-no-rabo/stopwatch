`timescale 1ns / 1ps
module mux_16_1(
	input wire rclk,
	input wire[3:0] address,
	input wire[23:0] regQ0, regQ1, regQ2, regQ3, regQ4,
		regQ5, regQ6, regQ7, regQ8, regQ9, regQ10,
		regQ11, regQ12, regQ13, regQ14, regQ15,
	output reg[23:0] data_out);
	
	always @(posedge rclk) begin
		case (address[3:0])
			4'b0000: data_out = regQ0;
			4'b0001: data_out = regQ1;
			4'b0010: data_out = regQ2;
			4'b0011: data_out = regQ3;
			4'b0100: data_out = regQ4;
			4'b0101: data_out = regQ5;
			4'b0110: data_out = regQ6;
			4'b0111: data_out = regQ7;
			4'b1000: data_out = regQ8;
			4'b1001: data_out = regQ9;
			4'b1010: data_out = regQ10;
			4'b1011: data_out = regQ11;
			4'b1100: data_out = regQ12;
			4'b1101: data_out = regQ13;
			4'b1110: data_out = regQ14;
			4'b1111: data_out = regQ15;
		endcase
	end
endmodule
