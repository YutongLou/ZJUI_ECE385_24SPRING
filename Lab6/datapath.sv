module datapath (input logic Reset, Clk,
					  input logic LD_MAR, //8 LD
									  LD_MDR,
							  		LD_IR,
								   LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				input logic    GatePC, //4 Gate
									GateMDR,
									GateALU,
									GateMARMUX,
									
				input logic [1:0]  PCMUX,ADDR2MUX,ALUK, //6 MUX
				input logic   DRMUX, //4 MUX
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				input logic MIO_EN, //Special Select
				input logic [15:0] MDR_In,
				output logic [15:0] IR, MAR, MDR, PC,
				output logic [11:0] LED,
				output logic BEN );
	
	logic [15:0] Offset, Base, ADD_new, PC_cre, PC_new, MDR_new, BUS, 
						SR1, SR2, OP2, ALU;
	logic [2:0] DR_s, SR1_s, SR2_s;
	
	assign MDR_new = (MIO_EN)? MDR_In: BUS;
	Reg PC_reg(.Clk, .Reset(Reset), .Load(LD_PC), .D(PC_new), .Q(PC));
	Reg MAR_reg (.Clk, .Reset(Reset), .Load(LD_MAR), .D(BUS), .Q(MAR));
	Reg MDR_reg (.Clk, .Reset(Reset), .Load(LD_MDR), .D(MDR_new), .Q(MDR));
	Reg IR_reg (.Clk, .Reset(Reset), .Load(LD_IR), .D(BUS), .Q(IR));
	Reg #(12) LED_reg (.Clk, .Reset(Reset), .Load(LD_LED), .D(IR[11:0]), .Q(LED));
	
	
	//Address adder Unit
	Mux_4 ADDR2_mux(.S(ADDR2MUX), .A(16'h0000), .B({{10{IR[5]}},IR[5:0]}), 
					.C({{7{IR[8]}},IR[8:0]}), .D({{5{IR[10]}},IR[10:0]}), .Out(Offset));
	assign Base = (ADDR1MUX)? SR1 : PC;
	assign ADD_new = Base + Offset;
	
	//PC unit
	assign PC_cre = PC + 1;
	Mux_4 PC_mux(.S(PCMUX), .A(PC_cre), .B(BUS), .C(ADD_new), .D({16{1'bX}}), .Out(PC_new));	

	//Reg file
	assign DR_s = (DRMUX)? 3'b111: IR[11:9];
	assign SR1_s = (SR1MUX)? IR[8:6]: IR[11:9];
	assign SR2_s = IR[2:0];
	Reg_file myReg_file (.Reset(Reset), .Clk, .Load(LD_REG), .DR_s, .SR1_s, .SR2_s, .D_in(BUS), .SR1, .SR2);
	
	//ALU
	assign OP2 = (SR2MUX)? {{11{IR[4]}},IR[4:0]}: SR2;
	always_comb
		begin
			case(ALUK)
				2'b00: ALU = OP2 + SR1;
				2'b01: ALU = OP2 & SR1;
				2'b10: ALU = ~ SR1;
				2'b11: ALU = SR1;
				default: ALU = {16{1'bX}};
			endcase
		end
	
	//CC and BEN
	logic n_new, z_new, p_new, n, z, p;
	always_comb
		begin	
			n_new = BUS[15];
			z_new = ~(BUS[15]|BUS[14]|BUS[13]|BUS[12]|BUS[11]|BUS[10]|BUS[9]|BUS[8]|BUS[7]|BUS[6]|BUS[5]|BUS[4]|BUS[3]|BUS[2]|BUS[1]|BUS[0]);
			p_new = (~BUS[15])&(BUS[14]|BUS[13]|BUS[12]|BUS[11]|BUS[10]|BUS[9]|BUS[8]|BUS[7]|BUS[6]|BUS[5]|BUS[4]|BUS[3]|BUS[2]|BUS[1]|BUS[0]);
		end
	Reg #(3) CC_reg(.Clk, .Reset, .Load(LD_CC), .D({n_new,z_new,p_new}), .Q({n,z,p}));
	Reg #(1) BEN_reg(.Clk, .Reset, .Load(LD_BEN), .D((n&IR[11])|(z&IR[10])|(p&IR[9])), .Q(BEN));
	
	//BUS unit
	always_comb
		begin
			case({GatePC,GateMDR,GateALU,GateMARMUX})
				4'b0001: BUS = ADD_new;
				4'b0010: BUS = ALU;
				4'b0100: BUS = MDR;
				4'b1000: BUS = PC;
				default: BUS = {16{1'bX}};
			endcase
		end
		
endmodule 