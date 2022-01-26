module MEM_WB(
	// Outputs
	output reg RegWriteOut,
	output reg [31:0]ResultOut,
	output reg [4:0]RdAddrOut,
	// Inputs
	input wire RegWrite,
	input wire [31:0]Result,
	input wire [4:0]RdAddr,
	input wire clk
);

	always @ (posedge clk)
	begin
		RegWriteOut <= RegWrite;
		ResultOut <= Result;
		RdAddrOut <= RdAddr;
	end
endmodule