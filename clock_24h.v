`timescale 1ns / 1ps
module clock_24h(
	input wire clk_sec,
	output wire[23:0] digit,
	output wire clk_min, clk_hour, clk_day);
	
	wire[3:0] sec_low,sec_high,min_low,min_high,hour_low,hour_high;
	m_gen_sec SEC(clk_sec,clk_min,sec_low,sec_high);
	m_gen_min MIN (clk_min, clk_hour, min_low, min_high);
	m_gen_hour HOUR(clk_hour, clk_day, hour_low, hour_high);
	assign digit[23:20] = hour_high[3:0] ;
	assign digit[19:16] = hour_low[3:0] ;
	assign digit[15:12] = min_high[3:0] ;
	assign digit[11:8]  = min_low[3:0] ;
	assign digit[7:4]   = sec_high[3:0];
	assign digit[3:0]   = sec_low[3:0];

endmodule
