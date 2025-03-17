module adder_1 (input logic a, b, c_in,
					output logic s, c_out);
	always_comb
		begin
			s = a ^ b ^ c_in;
			c_out = (a&b) | (a&c_in) | (b&c_in);
		end
		
endmodule 

module adder_4 (input logic [3:0] a, b,
					 input logic c_in,
					 output logic [3:0] s,
					 output logic c_out);
	logic c [2:0];
	adder_1 adder0 (.a(a[0]), .b(b[0]), .c_in, .s(s[0]), .c_out(c[0]));
	adder_1 adder1 (.a(a[1]), .b(b[1]), .c_in(c[0]), .s(s[1]), .c_out(c[1]));
	adder_1 adder2 (.a(a[2]), .b(b[2]), .c_in(c[1]), .s(s[2]), .c_out(c[2]));
	adder_1 adder3 (.a(a[3]), .b(b[3]), .c_in(c[2]), .s(s[3]), .c_out);
	
endmodule 

module adder_8 (input logic [7:0] a, b,
					 input logic c_in,
					 output logic [7:0] s,
					 output logic c_out);
	logic c3;
	adder_4 adder4 (.a(a[3:0]), .b(b[3:0]), .c_in, .s(s[3:0]), .c_out(c3));
	adder_4 adder5 (.a(a[7:4]), .b(b[7:4]), .c_in(c3), .s(s[7:4]), .c_out);
	
endmodule 