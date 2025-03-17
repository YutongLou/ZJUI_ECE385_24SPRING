module Reg_file(input logic [2:0] DR_s, SR1_s, SR2_s,
					 input logic [15:0] D_in,
					 input logic Load, Reset, Clk,
					 output logic [15:0] SR1, SR2);
	logic [15:0] Reg [7:0];
	always_ff @(posedge Clk)
		begin
			if (Reset)
				begin
					for(integer i = 0; i < 8; i = i + 1)
						begin
							Reg [i] <= 16'b0;
						end 
				end
			else if (Load)
				begin
					case (DR_s)
						3'b000: Reg[0] <= D_in;
						3'b001: Reg[1] <= D_in;
						3'b010: Reg[2] <= D_in;
						3'b011: Reg[3] <= D_in;
						3'b100: Reg[4] <= D_in;
						3'b101: Reg[5] <= D_in;
						3'b110: Reg[6] <= D_in;
						3'b111: Reg[7] <= D_in;
					endcase
				end
		end
	always_comb
		begin 
			case(SR1_s)
				3'b000: SR1 = Reg[0];
            3'b001: SR1 = Reg[1];
            3'b010: SR1 = Reg[2];
            3'b011: SR1 = Reg[3];
            3'b100: SR1 = Reg[4];
            3'b101: SR1 = Reg[5];
            3'b110: SR1 = Reg[6];
            3'b111: SR1 = Reg[7];
			endcase
			
			case(SR2_s)
				3'b000: SR2 = Reg[0];
            3'b001: SR2 = Reg[1];
            3'b010: SR2 = Reg[2];
            3'b011: SR2 = Reg[3];
            3'b100: SR2 = Reg[4];
            3'b101: SR2 = Reg[5];
            3'b110: SR2 = Reg[6];
            3'b111: SR2 = Reg[7];
			endcase
		end
endmodule 