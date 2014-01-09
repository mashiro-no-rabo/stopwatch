`timescale 1ns / 1ps
module calc(
// clock
	input wire clk, 
// pushbuttons
	input wire start_in, pause_in,
	input wire record_in, recall_mode_in,
// switchs
	input wire display_mode, // 0 is min/sec
	input wire[3:0] reg_address,
// seven seg
	output wire[3:0] anode,
	output wire[7:0] segment,
// LEDs
	output wire started_LED,
	output wire paused_LED,
	output wire write_LED,
	output wire mode_LED);
	
	// wire seven seg
	reg[15:0] display_num;
	initial begin
		display_num = 16'b0;
	end
	display_16 seven_seg(clk, display_num, anode[3:0], segment[7:0]);
	
	// debounce push buttons
	wire start_stop, pause_resume, record_recall, recall_mode;
	pbdebounce p0(clk, start_in, start_stop);
	pbdebounce p1(clk, pause_in, pause_resume);
	pbdebounce p2(clk, record_in, record_recall);
	pbdebounce p3(clk, recall_mode_in, recall_mode);

	// the stopwatch
	wire[23:0] result;
	wire reg_exceed;
	stop_watch sw(clk,
		start_stop, pause_resume,
		record_recall, recall_mode,
		reg_address,
		reg_exceed,
		started_LED, paused_LED,
		write_LED, mode_LED,
		result);
	
	// choose display
	always @* begin
		if (reg_exceed)
			display_num = 16'hEFFD; // F will display "r", D will display "."
		else
			case(display_mode)
				1'b0: display_num = result[23:8];
				1'b1: display_num = result[15:0];
			endcase
	end

endmodule
