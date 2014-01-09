`timescale 1ns / 1ps
module regfile(
	input wire wclk, rclk,
	input wire[3:0] address,
	input wire[23:0] data_in,
	output wire[23:0] data_out);
	
	wire[15:0] Yi;
	wire[15:0] clk;
	
	assign clk[15:0] = {16{wclk}} & Yi;
	
	wire[23:0] regQ0, regQ1, regQ2, regQ3, regQ4,
		regQ5, regQ6, regQ7, regQ8, regQ9, regQ10,
		regQ11, regQ12, regQ13, regQ14, regQ15;
	
	decoder_4_16 m0(address, wclk, Yi);
	mux_16_1 m1(rclk, address, regQ0, regQ1, regQ2, regQ3, regQ4,
		regQ5, regQ6, regQ7, regQ8, regQ9, regQ10,
		regQ11, regQ12, regQ13, regQ14, regQ15, data_out);
	
	register24 r0(clk[0], data_in, regQ0),
		r1(clk[1], data_in, regQ1),
		r2(clk[2], data_in, regQ2),
		r3(clk[3], data_in, regQ3),
		r4(clk[4], data_in, regQ4),
		r5(clk[5], data_in, regQ5),
		r6(clk[6], data_in, regQ6),
		r7(clk[7], data_in, regQ7),
		r8(clk[8], data_in, regQ8),
		r9(clk[9], data_in, regQ9),
		r10(clk[10], data_in, regQ10),
		r11(clk[11], data_in, regQ11),
		r12(clk[12], data_in, regQ12),
		r13(clk[13], data_in, regQ13),
		r14(clk[14], data_in, regQ14),
		r15(clk[15], data_in, regQ15);
	
endmodule
