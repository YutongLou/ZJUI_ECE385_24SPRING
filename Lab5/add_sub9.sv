module add_sub8 (input logic [7:0] a,b,
						input logic fn,
						output logic [7:0] s,
						output logic c_out);
	logic [7:0] newb;

	assign newb = (b ^ {8{fn}});
	
	adder_8 ra (.a, .b(newb), .c_in(fn), .s, .c_out);
	
endmodule 

module add_sub9 (input logic [7:0] a,b,
						input logic fn,
						output logic [8:0] s);
						
	logic c_out, newb;
	assign newb = b[7] ^ fn;
	add_sub8 a_s (.a, .b, .fn, .s(s[7:0]), .c_out);
	adder_1 ra2 (.a(a[7]), .b(newb),.c_in(c_out),.s(s[8]));
	
endmodule 