module mux5_bits_RF(
	// Outputs
	output reg [4:0]RdAddr,
	// Inputs
	input wire [4:0]Instr20_16, Instr15_11,
	input wire RegDst
);

	always @ (*)
	begin 
		if (RegDst == 1)RdAddr <= Instr15_11;
		else RdAddr <= Instr20_16;
	end
	
endmodule
