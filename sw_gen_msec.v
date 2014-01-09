`timescale 1ns / 1ps
module sw_gen_msec(
	input wire clk_msec,
	input wire reset,
	output reg clk_sec,
	output reg[3:0] msec_low, msec_high);
	
	initial begin
		msec_low = 0;
		msec_high = 0;
	end
 
	always @(posedge clk_msec) begin
		if (msec_low == 9) begin
			msec_low = 0;
			clk_sec = 0;
			if (msec_high == 9) begin
				msec_high = 0; // grow second
				clk_sec = 1;
			end
			else
				msec_high = msec_high + 1;
			end
		else
			msec_low = msec_low + 1;
	end

endmodule
