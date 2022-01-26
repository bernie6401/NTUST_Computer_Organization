`define R_type		2'b10
`define lw_sw_addi	2'b00
`define subi		2'b01
`define beq			2'b11

`define Addu	6'b001001	//Add unsigned(09)
`define Subu	6'b001010	//Subtract unsigned(0A)
`define And		6'b010001	//And(11)
`define SLL		6'b100001	//Shift Left Logical(21)

module ALU_Control
(
	funct, ALUOp,
	Funct1
);

	input wire [5:0]funct;
	input wire [1:0]ALUOp;
	output reg[5:0]Funct1;
	
	always @ (*)
	begin
		case(ALUOp)
			`R_type:	case(funct)
							6'b001011:	Funct1 <= `Addu;
							6'b001101:	Funct1 <= `Subu;
							6'b010010:	Funct1 <= `And;
							6'b100110:	Funct1 <= `SLL;
						endcase
			`lw_sw_addi:Funct1 <= `Addu;
			`subi:		Funct1 <= `Subu;
			//`beq:		Funct1 <= 0;
			default: 	Funct1 <= 6'b0;
		endcase
		
	end
	
endmodule