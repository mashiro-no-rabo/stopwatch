`timescale 1ns / 1ps
module sw_gen_sec(
	input wire clk_sec,
	input wire reset,
	output reg clk_min,
	output reg[3:0] sec_low, sec_high);
	
	initial begin
		sec_low = 0;
		sec_high = 0;
	end
 
	always @(posedge clk_sec or posedge reset) begin
		if (reset) begin
			sec_low = 0;
			sec_high = 0;
		end
		else
			if (sec_low == 9) begin
				sec_low = 0;
				clk_min = 0;
				if (sec_high == 5) begin
					sec_high = 0; // grow min
					clk_min = 1;
				end
				else
					sec_high = sec_high + 1;
				end
			else
				sec_low = sec_low + 1;
	end

endmodule
