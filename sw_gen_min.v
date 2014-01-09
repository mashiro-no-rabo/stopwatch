`timescale 1ns / 1ps
module sw_gen_min(
	input wire clk_min,
	input wire reset,
	output reg[3:0] min_low, min_high);
	
	initial begin
		min_low = 0;
		min_high = 0;
	end
 
	always @(posedge clk_min or posedge reset) begin
		if (reset) begin
			min_low = 0;
			min_high = 0;
		end
		else
			if (min_low == 9) begin
				min_low = 0;
				if (min_high == 9) begin
					min_high = 0;
				end
				else
					min_high = min_high + 1;
				end
			else
				min_low = min_low + 1;
	end

endmodule
