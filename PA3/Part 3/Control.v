`define R_type   6'b000100
`define addi	 6'b001100
`define subi	 6'b001101
`define sw		 6'b010000
`define lw		 6'b010001

module Control
(
	OpCode,
	RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg, ALUOp
);

	input wire [5:0]OpCode;
	output reg RegDst, RegWrite, ALUSrc, MemWrite, MemRead, MemtoReg;
	output reg [1:0]ALUOp;
	
	always @ (OpCode)
	begin
		case(OpCode)
			`R_type:
				begin 
					ALUOp		= 2'b10;
					RegDst		= 1;
					ALUSrc		= 0;
					MemtoReg	= 0;
					RegWrite	= 1;
					MemRead		= 0;
					MemWrite	= 0;
				end
			
			`addi:
				begin 
					ALUOp		= 2'b00;
					RegDst		= 0;
					ALUSrc		= 1;
					MemtoReg	= 0;
					RegWrite	= 1;
					MemRead		= 0;
					MemWrite	= 0;
				end
			
			`subi:
				begin 
					ALUOp		= 2'b01;
					RegDst		= 0;
					ALUSrc		= 1;
					MemtoReg	= 0;
					RegWrite	= 1;
					MemRead		= 0;
					MemWrite	= 0;
				end
			
			`sw:
				begin 
					ALUOp		= 2'b00;
					RegDst		= 0;//don't care
					ALUSrc		= 1;
					MemtoReg	= 0;//don't care
					RegWrite	= 0;
					MemRead		= 0;
					MemWrite	= 1;
				end
			
			`lw:
				begin 
					ALUOp		= 2'b00;
					RegDst		= 0;
					ALUSrc		= 1;
					MemtoReg	= 1;
					RegWrite	= 1;
					MemRead		= 1;
					MemWrite	= 0;
				end
			default:
				begin
					ALUOp		= 2'b11;
					//RegDst		= 0;
					//ALUSrc		= 1;
					//MemtoReg	= 1;
					RegWrite	= 0;
					MemRead		= 0;
					MemWrite	= 0;
				end
		endcase
	end
endmodule