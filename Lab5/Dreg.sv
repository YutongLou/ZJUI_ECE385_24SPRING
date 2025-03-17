module Dreg (input logic clk, reset, load, D,
            output logic Q);
  always_ff @(posedge clk or posedge reset)
	begin 
		if(reset)
			Q <= 1'b0;
		else if (load)
			Q <= D;
		else 
			Q <= Q;
	end
endmodule 