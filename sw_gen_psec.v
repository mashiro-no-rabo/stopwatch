`timescale 1ns / 1ps
module sw_gen_psec(
	input wire clk_psec,
	input wire reset,
	output reg clk_sec,
	output reg[3:0] psec_low, psec_high);
	
	initial begin
		psec_low = 0;
		psec_high = 0;
	end
 
	always @(posedge clk_psec or posedge reset) begin
		if (reset) begin
			psec_low = 0;
			psec_high = 0;
		end
		else
			if (psec_low == 9) begin
				psec_low = 0;
				clk_sec = 0;
				if (psec_high == 9) begin
					psec_high = 0; // grow second
					clk_sec = 1;
				end
				else
					psec_high = psec_high + 1;
				end
			else
				psec_low = psec_low + 1;
	end

endmodule
