module IF_ID(
	// Outputs
	output reg [31:0]InstrOut,
	// Inputs
	input wire [31:0]InstrIn,
	input wire clk
);

	always @ (posedge clk)
	begin
		InstrOut <= InstrIn;
	end
endmodule