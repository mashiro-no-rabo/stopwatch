`timescale 1ns / 1ps
module m_gen_hour(
	input wire clk_hour,
	output reg clk_day,
	output reg[3:0] hour_low, hour_high
	);
	
	initial begin
		hour_low = 3;
		hour_high = 2;
	end

	always @(posedge clk_hour) begin
		clk_day=0;
		if (hour_low == 3 && hour_high == 2) begin
			hour_low = 0;
			hour_high = 0;
			clk_day = 1;
		end
		else if (hour_low == 9) begin
			hour_low = 0;
			hour_high = hour_high + 1;
		end
		else
			hour_low = hour_low + 1;
	end

endmodule
