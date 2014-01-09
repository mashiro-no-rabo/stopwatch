`timescale 1ns / 1ps
module timer_1ps(
	input wire clk,
	output reg clk_1ps);
	
	reg[18:0] cnt;
	initial begin
		cnt[18:0] <= 0;
		clk_1ps <= 0;
	end
	
	always @(posedge clk)
		if (cnt >= 250000) begin
			cnt <= 0;
			clk_1ps <= ~clk_1ps;
		end
		else begin
			cnt <= cnt+1;
		end

endmodule