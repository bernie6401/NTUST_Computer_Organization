module Control
(
	OpCode,
	RegWrite, ALUOp
);

	input wire [5:0]OpCode;
	output reg RegWrite;
	output reg [1:0]ALUOp;
	
	always @ (OpCode)
	begin
		if(OpCode == 6'b000100)
		begin 
			ALUOp=2'b10;
			RegWrite = 1;
		end
		else
		begin
			ALUOp		= 2'b11;
			RegWrite	= 0;
		end
	end
endmodule