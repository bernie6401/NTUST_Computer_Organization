module mux_Control(
	// Outputs
	output reg [1:0]ALUOp_Control_mux,
	output reg RegDst_Control_mux, RegWrite_Control_mux, ALUSrc_Control_mux, MemWrite_Control_mux, MemRead_Control_mux, MemtoReg_Control_mux,
	// Inputs
	input wire [1:0]ALUOp,
	input wire RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, hazard_control
);

	always @ (*)
	begin 
		if (hazard_control == 1)
		begin 
			ALUOp_Control_mux <= 0;
			RegDst_Control_mux <= 0;
			RegWrite_Control_mux <= 0;
			ALUSrc_Control_mux <= 0;
			MemWrite_Control_mux <= 0;
			MemRead_Control_mux <= 0;
			MemtoReg_Control_mux <= 0;
		end
		else 
		begin
			ALUOp_Control_mux <= ALUOp;
			RegDst_Control_mux <= RegDst;
			RegWrite_Control_mux <= RegWrite;
			ALUSrc_Control_mux <= ALUSrc;
			MemWrite_Control_mux <= MemWrite;
			MemRead_Control_mux <= MemRead;
			MemtoReg_Control_mux <= MemtoReg;
		end
	end
	
endmodule
