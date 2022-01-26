module mux32_bits_ALU(
	// Outputs
	output reg [31:0]ALU_input,
	// Inputs
	input wire [31:0]ForwardB_out,
	input wire [31:0]signextend,
	input wire ALUSrc
);
	
	always @ (*)
	begin
		if (ALUSrc== 1)ALU_input = signextend;
		else ALU_input = ForwardB_out;
	end
	
endmodule
