module shiftreg_8 (input logic reset, load, shift, shift_in, clk,
						input logic [7:0] D_in,
						output logic shift_out,
						output logic [7:0] D_out);
	always_ff @(posedge clk or posedge reset) 
		begin
			if (reset)
				D_out <= 8'h0;
			else if (load)
				D_out <= D_in;
			else if (shift)
				D_out <= {shift_in, D_out[7:1]};
		end

assign	shift_out = D_out[0];
endmodule

		