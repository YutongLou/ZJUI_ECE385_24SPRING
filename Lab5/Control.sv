module Control (input logic clk, reset, c_l, run, M, 
                output logic shift, loadA, loadB, resetA, resetB, fn);
					 
	enum logic[5:0] {idle, pre, halt, a1, a2, a3, a4, a5, a6, a7, a8, s1, s2, s3, s4, s5, s6, s7, s8} curr_state, next_state;
	always_ff @(posedge clk or posedge reset)
		begin
			if(reset)
				curr_state <= idle;
			else
				curr_state <= next_state;
		end
	always_comb
		begin
			next_state = curr_state;
			case(curr_state)
				idle: if (run)
						next_state = pre;
				pre: next_state = a1;
				a1: next_state = s1;
				s1: next_state = a2;
				a2:  next_state = s2;
				s2:  next_state = a3;
				a3:  next_state = s3;
				s3:  next_state = a4;
				a4:  next_state = s4;
				s4:  next_state = a5;
				a5:  next_state = s5;
				s5:  next_state = a6;
				a6:  next_state = s6;
				s6:  next_state = a7;
				a7:  next_state = s7;
				s7:  next_state = a8;
				a8:  next_state = s8;
				s8:  next_state = halt;
				halt: if(!run)
							next_state = idle;
			endcase
		end
	always_comb
		begin	
		shift = 1'b0;
		loadA = 1'b0;
		loadB = 1'b0;
		resetA = 1'b0;
		resetB = 1'b0;
		fn = 1'b0;
			case(curr_state)
				idle: 
					begin
						loadB = c_l;
						resetA = reset|c_l;
						resetB = reset;
					end
				pre: 
					resetA = 1'b1;
				a1, a2, a3, a4, a5, a6, a7:
					begin
						loadA = M;
					end
				a8: 
					begin
						loadA = M;
						fn = M;
					end
				s1, s2, s3, s4, s5, s6, s7, s8:
					begin
						shift = 1'b1;
					end
				halt:
					begin
						shift = 1'b0;
						loadA = 1'b0;
                  loadB = 1'b0;
						resetA = 1'b0;
                  resetB = 1'b0;
					end			
				default:
					begin
						shift = 1'b0;
						loadA = 1'b0;
                  loadB = 1'b0;
						resetA = 1'b0;
                  resetB = 1'b0;
					end
			endcase
		end
endmodule
	