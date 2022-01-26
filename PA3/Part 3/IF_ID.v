module IF_ID(
	// Outputs
	output reg [31:0]InstrOut,
	// Inputs
	input wire [31:0]InstrIn,
	input wire IF_ID_Write, clk
);

	always @ (posedge clk)
	begin
		if (IF_ID_Write == 1) InstrOut <= 31'b0;
		else InstrOut <= InstrIn;
	end
	
	always @ (negedge clk)
	begin
		if (IF_ID_Write == 1) InstrOut <= 31'b0;
	end
endmodule