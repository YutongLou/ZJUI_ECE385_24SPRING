
module nios (
	clk_clk,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	vga_port_blue,
	vga_port_blank,
	vga_port_green,
	vga_port_red,
	vga_port_hs,
	vga_port_vs,
	vga_port_sync,
	vga_port_pixel_clk);	

	input		clk_clk;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output	[3:0]	vga_port_blue;
	output		vga_port_blank;
	output	[3:0]	vga_port_green;
	output	[3:0]	vga_port_red;
	output		vga_port_hs;
	output		vga_port_vs;
	output		vga_port_sync;
	output		vga_port_pixel_clk;
endmodule
