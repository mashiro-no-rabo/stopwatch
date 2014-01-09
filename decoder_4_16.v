`timescale 1ns / 1ps
module decoder_4_16(
	input wire[3:0] address,
	input wire wclk,
	output reg[15:0] Yi);
	
	always @* begin
		if (wclk == 1'b1)
			case (address[3:0])
				4'b0000: Yi = 16'h0001;
				4'b0001: Yi = 16'h0002;
				4'b0010: Yi = 16'h0004;
				4'b0011: Yi = 16'h0008;
				4'b0100: Yi = 16'h0010;
				4'b0101: Yi = 16'h0020;
				4'b0110: Yi = 16'h0040;
				4'b0111: Yi = 16'h0080;
				4'b1000: Yi = 16'h0100;
				4'b1001: Yi = 16'h0200;
				4'b1010: Yi = 16'h0400;
				4'b1011: Yi = 16'h0800;
				4'b1100: Yi = 16'h1000;
				4'b1101: Yi = 16'h2000;
				4'b1110: Yi = 16'h4000;
				4'b1111: Yi = 16'h8000;
			endcase
		else
			Yi = 16'h0000;
	end
endmodule
