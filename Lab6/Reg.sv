module Reg #(N = 16) (input logic Clk, Reset, Load,
							input logic [N-1:0] D,
							output logic [N-1:0] Q);
							
	 always_ff @(posedge Clk)
		begin 
			if (Reset)
				Q <= {N{1'b0}};
			else if (Load)
				Q <= D;
			else
				Q <= Q;
		end
endmodule 