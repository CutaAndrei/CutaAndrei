module procesor_monociclu
(
	input clk,
	input rst,
	
	output [31:0] DataMem_int,
	output [31:0] NextAddress_int,
	output [31:0] CurrentAddress_int,
	output [31:0] CurrentInstruction_int,
	output [31:0] data1_int,
	output [31:0] data2_int
);

wire [31:0] tmp_next_address;
wire [31:0] tmp_address;
wire [31:0] tmp_instruction;

wire 		tmp_RegDst;
wire		tmp_Jump;
wire		tmp_Branch;
wire		tmp_MemRead;
wire		tmp_MemToReg;
wire [ 1:0] tmp_ALUOp;
wire		tmp_MemWrite;
wire		tmp_ALUSrc;
wire		tmp_RegWrite;

wire [ 4:0] tmp_Write_register;
wire [31:0] tmp_Write_data_register;
wire [31:0] tmp_Read_data1;	
wire [31:0] tmp_Read_data2;	

wire [31:0] tmp_sign_extend;

wire [ 5:0] tmp_ALU_control_dout;

wire		tmp_zero;
wire [31:0] tmp_ALU_b;
wire [31:0] tmp_ALU_result;

wire [31:0] tmp_Read_data_Memory; 

wire [31:0] tmp_PC_4;

wire [31:0] JumpAddress;

wire [31:0] tmp_shift_2_out;

wire [31:0] tmp_U14_result;

wire [31:0] tmp_U15_out;


	PC 
	U0 (
		.clk(clk),
		.rst(rst),
		.next_address(tmp_next_address),
		.address(tmp_address)
	); 
	
	
	Instruction_memory #(.N(32), .W(8) ) 
	U1(
		.address(tmp_address),
		.instruction(tmp_instruction)
	); 
	
	Control
	U2(
		.op(tmp_instruction[31:26]),
		.RegDst(tmp_RegDst),
		.Jump(tmp_Jump),
		.Branch(tmp_Branch),
		.MemRead(tmp_MemRead),
		.MemToReg(tmp_MemToReg),
		.ALUOp(tmp_ALUOp),
		.MemWrite(tmp_MemWrite),
		.ALUSrc(tmp_ALUSrc),
		.RegWrite(tmp_RegWrite)
	);
	
	Registers
	U3(	
		.clk(clk), //!
		.rst(rst),
		.RegWrite(tmp_RegWrite),
		.Read_register1(tmp_instruction[25:21]),
		.Read_register2(tmp_instruction[20:16]),
		.Write_register(tmp_Write_register),
		.Write_data(tmp_Write_data_register),
		.Read_data1(tmp_Read_data1),
		.Read_data2(tmp_Read_data2)
	);
	
	mux2_1 #(.N(5))
	U4(
		.sel(tmp_RegDst),
		.in0(tmp_instruction[20:16]),
		.in1(tmp_instruction[15:11]),
		.out(tmp_Write_register)
	); 
	
	sign_extend #(.N(16), .M(32))
	U5(
		.data_in(tmp_instruction[15:0]),
		.data_out(tmp_sign_extend)
	);
	
	ALU_control
	U6(
		.funct(tmp_instruction[5:0]),
		.ALUop(tmp_ALUOp),
		.dout(tmp_ALU_control_dout)
	);
	
	mux2_1 #(.N(32))
	U7(
		.sel(tmp_ALUSrc),
		.in0(tmp_Read_data2),
		.in1(tmp_sign_extend),
		.out(tmp_ALU_b)
	); 
	
	ALU
	U8(
		.a(tmp_Read_data1),
		.b(tmp_ALU_b),
		.alu_control(tmp_ALU_control_dout),
		.zero(tmp_zero),
		.result(tmp_ALU_result)
	);
	
	data_memory	#(.N(32), .W(32))
	U9(
		.MemWrite(tmp_MemWrite),
		.MemRead(tmp_MemRead),
		.write_data(tmp_Read_data2),
		.address(tmp_ALU_result),
		.read_data(tmp_Read_data_Memory)
	);
	
	mux2_1 #(.N(32))
	U10(
		.sel(tmp_MemToReg),
		.in0(tmp_ALU_result),
		.in1(tmp_Read_data_Memory),
		.out(tmp_Write_data_register)
	); 
	
	ALU
	U11(
		.a(tmp_address),
		.b(32'd4),
		.alu_control(6'b100001),
		.zero(),
		.result(tmp_PC_4)
	);
	
	shift_left_2 #(.N(26) , .M(28) )
	U12(
		.data_in(tmp_instruction[25:0]),
		.data_out(JumpAddress[27:0])
	);
	assign JumpAddress[31:28] = tmp_PC_4[31:28];
	
	shift_left_2 #(.N(32) , .M(32) )
	U13(
		.data_in(tmp_sign_extend),
		.data_out(tmp_shift_2_out)
	);
	
	ALU
	U14(
		.a(tmp_PC_4),
		.b(tmp_shift_2_out),
		.alu_control(6'b100001),
		.zero(),
		.result(tmp_U14_result)
	);
	
wire and_gate; 
assign and_gate = tmp_Branch & tmp_zero;

	mux2_1 #(.N(32))
	U15(
		.sel(and_gate),
		.in0(tmp_PC_4),
		.in1(tmp_U14_result),
		.out(tmp_U15_out)
	); 
	
	mux2_1 #(.N(32))
	U16(
		.sel(tmp_Jump),
		.in0(tmp_U15_out),
		.in1(JumpAddress),
		.out(tmp_next_address)
	); 
	
	
	assign CurrentInstruction_int = tmp_instruction;
	assign DataMem_int = tmp_Write_data_register;
	assign NextAddress_int = tmp_next_address;
	assign CurrentAddress_int = tmp_address;
	assign data1_int = tmp_Read_data1;
	assign data2_int = tmp_Read_data2;
	
endmodule
