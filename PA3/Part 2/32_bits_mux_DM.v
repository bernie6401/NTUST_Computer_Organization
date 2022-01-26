module mux32_bits_DM(
	// Outputs
	output reg [31:0]RdData,
	// Inputs
	input wire [31:0]MemReadData, ALU_output,
	input wire MemtoReg
);

	
	always @ (*)
	begin 
		if (MemtoReg== 1)RdData<=MemReadData;
		else RdData<=ALU_output;
	end
	
endmodule
