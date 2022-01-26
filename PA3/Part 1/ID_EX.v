module ID_EX(
	// Outputs
	output reg [1:0]ALUOpOut,
	output reg RegWriteOut,
	output reg [31:0]RsDataOut,RtDataOut,
	output reg [5:0]FunctOut,
	output reg [4:0]ShamtOut, RdAddrOut,
	// Inputs
	input wire [1:0]ALUOp,
	input wire clk, RegWrite,
	input wire [31:0]RsData,RtData,
	input wire [5:0]Funct, 
	input wire [4:0]Shamt, RdAddr
);

	always @ (posedge clk)
	begin
		ALUOpOut <= ALUOp;
		RegWriteOut <= RegWrite;
		RsDataOut <= RsData;
		RtDataOut <= RtData;
		FunctOut <= Funct;
		ShamtOut <= Shamt;
		RdAddrOut <= RdAddr;
	end
endmodule