// -----------------------------------------------------------------------------
// Copyright (c) 2014-2022 All rights reserved
// -----------------------------------------------------------------------------
// Author : 1598491517@qq.com
// File   : tb_fenpin8_7.v
// Create : 2022-05-06 22:18:17
// Revise : 2022-05-06 22:25:16
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_fenpin8_7();

reg clk_in;
reg rst;
wire clk_out;

initial begin
	clk_in = 1'b1;
	rst = 1'b0;
	#100;
	rst = 1'b1;
end
always #5 clk_in=~clk_in;
	div_M_N inst_div_M_N (
			.clk_in  (clk_in),
			.rst     (rst),
			.clk_out (clk_out)
		);

endmodule