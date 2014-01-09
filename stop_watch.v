`timescale 1ns / 1ps
module stop_watch(
	input wire clk,
	input wire start_stop, pause_resume,
	input wire record_recall, recall_mode,
	input wire[3:0] reg_address,
	output wire reg_exceed,
	output reg started, paused,
	output wire write, rmode,
	output wire[23:0] result);
	
	reg[3:0] rec_pos, dis_pos;
	
	initial begin
		started = 0;
		paused = 0;
		rec_pos = 0;
		dis_pos = 0;
	end
	
	// stopwatch control
	reg reset;
	
	always @(posedge start_stop) started <= ~started;
	always @(posedge pause_resume) paused <= ~paused;
	always @(negedge record_recall) begin
		if (started) begin
			rec_pos <= rec_pos + 1;
			dis_pos <= dis_pos + 1;
		end
		else
			if (dis_pos == rec_pos)
				dis_pos <= 0;
			else
				dis_pos <= dis_pos + 1;
	end
	always @(posedge clk) begin
		if (reset) reset <= 0;
		else if (~started & start_stop) reset <= 1;
	end
	
	// timer
	wire clk_psec, clock_psec;
	timer_1ps psec_clock(clk, clk_psec);
	assign clock_psec = started & (~paused) & clk_psec;
	wire[3:0] sec_low, sec_high, min_low, min_high, psec_low, psec_high;
	sw_gen_psec PSEC(clock_psec, reset, clk_sec, psec_low, psec_high);
	sw_gen_sec SEC(clk_sec, reset, clk_min, sec_low, sec_high);
	sw_gen_min MIN(clk_min, reset, min_low, min_high);
	wire[23:0] timer_result;
	assign timer_result[23:20] = min_high[3:0] ;
	assign timer_result[19:16] = min_low[3:0] ;
	assign timer_result[15:12] = sec_high[3:0] ;
	assign timer_result[11:8]  = sec_low[3:0] ;
	assign timer_result[7:4]   = psec_high[3:0];
	assign timer_result[3:0]   = psec_low[3:0];
	
	// registers
	wire[3:0] address;
	assign reg_exceed = recall_mode & (reg_address > rec_pos);
	assign address = (started) ? rec_pos : ((recall_mode) ? reg_address : dis_pos);
	wire[23:0] reg_out;
	assign write = (started & record_recall) | start_stop;
	regfile registers(write, (~started & clk), address, timer_result, reg_out);
	
	// wire output
	assign result = (started) ? timer_result : reg_out;
	assign rmode = recall_mode;
	
endmodule
