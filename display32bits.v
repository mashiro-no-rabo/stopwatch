`timescale 1ns / 1ps
module display32bits(
	input wire clk,
	input wire[31:0] disp_num,
	output reg[7:0] digit_anode,
	output reg[7:0] segment);
	
	reg[12:0] cnt = 0;
	reg[3:0] num;
	
	always @(posedge clk) begin
		case (cnt[12:10])
			3'b000: begin
					digit_anode <= 8'b1111_1110;
					num <= disp_num[3:0];
				end
			3'b001: begin
					digit_anode <= 8'b1111_1101;
					num <= disp_num[7:4];
				end
			3'b010: begin
					digit_anode <= 8'b1111_1011;
					num <= disp_num[11:8];
				end
			3'b011: begin
					digit_anode <= 8'b1111_0111;
					num <= disp_num[15:12];
				end
			3'b100: begin
					digit_anode <= 8'b1110_1111;
					num <= disp_num[19:16];
				end
			3'b101: begin
					digit_anode <= 8'b1101_1111;
					num <= disp_num[23:20];
				end
			3'b110: begin
					digit_anode <= 8'b1011_1111;
					num <= disp_num[27:24];
				end
			3'b111: begin
					digit_anode <= 8'b0111_1111;
					num <= disp_num[31:28];
				end
		endcase
		case (num)
			4'b0000: segment <= 8'b11000000;
			4'b0001: segment <= 8'b11111001;
			4'b0010: segment <= 8'b10100100;
			4'b0011: segment <= 8'b10110000;
			4'b0100: segment <= 8'b10011001;
			4'b0101: segment <= 8'b10010010;
			4'b0110: segment <= 8'b10000010;
			4'b0111: segment <= 8'b11111000;
			4'b1000: segment <= 8'b10000000;
			4'b1001: segment <= 8'b10010000;
			4'b1010: segment <= 8'b10001000;
			4'b1011: segment <= 8'b10000011;
			4'b1100: segment <= 8'b11000110;
			4'b1101: segment <= 8'b10100001;
			4'b1110: segment <= 8'b10000110;
			4'b1111: segment <= 8'b10001110;
			default: segment <= 8'b00000000;
		endcase
		cnt <= cnt + 1;
	end


endmodule
