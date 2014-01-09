`timescale 1ns / 1ps
module m_gen_min(
	input wire clk_min,
	output reg clk_hour,
	output reg[3:0] min_low, min_high
	);
	
	initial begin
		clk_hour = 0;
		min_low = 9;
		min_high = 5;
	end
	
	reg [15:0] cnt=0;
	always @(posedge clk_min) begin
		if (min_low == 9) begin
			min_low = 0;
			clk_hour = 0;
			if (min_high == 5) begin
				min_high = 0; /* base 6 */
				clk_hour = 1;
			end
			else
				min_high = min_high + 1;
		end
		else
			min_low = min_low + 1;
	end

endmodule
