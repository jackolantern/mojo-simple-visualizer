module mojo_top(
	input clk,
	input rst_n,

	output [7:0]d1_c,
	output [7:0]d1_r,
	output [7:0]d1_g,
	output [7:0]d1_b,
	output [7:0]d2_c,
	output [7:0]d2_r,
	output [7:0]d2_g,
	output [7:0]d2_b
);

wire rst = ~rst_n;

mstr_ctrl mstr_ctrl (
	.clk(clk),
	.rst(rst),
	.d1_c(d1_c),
	.d1_r(d1_r),
	.d1_g(d1_g),
	.d1_b(d1_b),
	.d2_c(d2_c),
	.d2_r(d2_r),
	.d2_g(d2_g),
	.d2_b(d2_b)
);

endmodule
