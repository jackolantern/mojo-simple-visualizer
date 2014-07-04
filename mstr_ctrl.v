module mstr_ctrl(
	input clk,
	input rst,
	output [7:0]d1_c,
	output [7:0]d1_r,
	output [7:0]d1_g,
	output [7:0]d1_b,
	output [7:0]d2_c,
	output [7:0]d2_r,
	output [7:0]d2_g,
	output [7:0]d2_b
);

localparam STATE_SIZE = 1;
localparam CREATE_FRAME = 1'b0,
	   WAIT_FLIP = 1'b1;

reg [STATE_SIZE-1:0] state_d, state_q;

reg [3:0] x_d, x_q;
reg [2:0] y_d, y_q;
reg [7:0] red_d, red_q;
reg [7:0] green_d, green_q;
reg [7:0] blue_d, blue_q;
reg valid_d, valid_q;
reg flip_d, flip_q;
wire flipped;
reg wait_fft_d, wait_fft_q;

led_display led_display (
	.clk(clk),
	.rst(rst),
	.x(x_q),
	.y(y_q),
	.red(red_q),
	.green(green_q),
	.blue(blue_q),
	.valid(valid_q),
	.flip(flip_q),
	.flipped(flipped),
	.d1_c(d1_c),
	.d1_r(d1_r),
	.d1_g(d1_g),
	.d1_b(d1_b),
	.d2_c(d2_c),
	.d2_r(d2_r),
	.d2_g(d2_g),
	.d2_b(d2_b)
);

always @(*) begin
	state_d = state_q;
	red_d = 8'h00;
	green_d = 8'h00;
	blue_d = 8'h00;
	flip_d = 1'b0;
	valid_d = 1'b0;
	x_d = x_q;
	y_d = y_q;
	wait_fft_d = 1'b0;

	case (state_q)
		CREATE_FRAME: begin
			wait_fft_d = ~wait_fft_q;
			if (wait_fft_q) begin
				x_d = x_q + 1'b1;
				if (x_q == 4'b1111) begin
					y_d = y_q + 1'b1;
					if (y_q == 3'b111) begin
						valid_d = 1'b0;
						flip_d = 1'b1;
						state_d = WAIT_FLIP;
					end
				end
			end

			valid_d = ~wait_fft_q;

			// This is where the magic happens!

			// Set the 3rd column to red.
			if (x_d == 4'b0010) begin
				red_d = 8'hff;
			end
			
			// Set the 5th column to blue.
			if (x_d == 4'b0100) begin
				blue_d = 8'hff;
			end
			
			// Etc.
			if (x_d == 4'b1000) begin
				green_d = 8'hff;
			end
		end
		WAIT_FLIP: begin
			if (flipped) begin
				state_d = CREATE_FRAME;
			end
		end
	endcase
end

always @(posedge clk) begin
	if (rst) begin
		state_q <= CREATE_FRAME;
		x_q <= 4'b0;
		y_q <= 3'b0;
	end else begin
		state_q <= state_d;
		x_q <= x_d;
		y_q <= y_d;
	end

	wait_fft_q <= wait_fft_d;
	red_q <= red_d;
	green_q <= green_d;
	blue_q <= blue_d;
	valid_q <= valid_d;
	flip_q <= flip_d;
end

endmodule
