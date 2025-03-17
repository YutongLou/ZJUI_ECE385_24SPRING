module Multiplier(input logic[7:0] S, 
						input logic Clk, Reset, Run, ClearA_LoadB,
						output logic [6:0] AhexU, AhexL, BhexU, BhexL,
						output logic [7:0] Aval, Bval,
						output logic X);
	logic reset, run, c_l;
	always_comb
		begin
		 reset = ~Reset;
		 run = ~Run;
       c_l = ~ClearA_LoadB;
		end

logic M, shift, loadA, loadB, resetA, resetB, fn, conbit;
logic [7:0] A, B;
logic [8:0] sum;

Control mycontrol (.clk(Clk), .reset, .c_l, .run, .M, .shift, .loadA, .loadB, .resetA, .resetB, .fn);			 

shiftreg_8 regA (.reset(resetA), .load(loadA), .shift(shift), .shift_in(X), .clk(Clk), .D_in(sum[7:0]), .shift_out(conbit), .D_out(A));

shiftreg_8 regB (.reset(resetB), .load(loadB), .shift(shift), .shift_in(conbit), .clk(Clk), .D_in(S), .shift_out(M), .D_out(B));

Dreg regX (.clk(Clk), .reset(resetA), .load(loadA), .D(sum[8]), .Q(X));

add_sub9 myadder(.a(A), .b(S), .fn, .s(sum));

HexDriver HexAL(.In(A[3:0]), .Out(AhexL));					
               
HexDriver HexAU(.In(A[7:4]), .Out(AhexU));
                             
HexDriver HexBL(.In(B[3:0]), .Out(BhexL));
                              
HexDriver HexBU(.In(B[7:4]), .Out(BhexU));

assign Aval = A;
assign Bval = B;
endmodule
