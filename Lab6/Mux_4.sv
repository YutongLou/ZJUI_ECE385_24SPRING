module Mux_4 #(N = 16)	(input logic [1:0] S,
								input logic [N-1:0] A,B,C,D,
								output logic [N-1:0] Out);
	always_comb 
		begin
			case(S)
				2'b00: Out = A;
				2'b01: Out = B;
				2'b10: Out = C;
				2'b11: Out = D;
				default: Out = {N{1'bX}};
			endcase
		end
		
endmodule 
				