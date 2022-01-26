`define Addu	6'b001001	//Add unsigned(09)
`define Subu	6'b001010	//Subtract unsigned(0A)
`define And		6'b010001	//And(11)
`define SLL		6'b100001	//Shift Left Logical(21)


module ALU
(
	Src1, Src2, Shamt, Funct1,
	Result, Zero, Carry	
);

	input Src1, Src2, Shamt, Funct1;
	output Result, Zero, Carry;
	
	wire [31:0] Src1;
	wire [31:0] Src2;
	wire [4:0] Shamt;
	wire [5:0] Funct1;
	reg [31:0] Result;
	reg Carry;
	reg Zero;
	
	always @ (Src1 or Shamt or Funct1 or Src2)
	begin
		case(Funct1)
			`Addu:		{Carry, Result} <= Src1 + Src2;
			`Subu:		{Carry, Result} <= Src1 - Src2;
			`And:		{Carry, Result} <= Src1 & Src2;
			`SLL:		{Carry, Result} <= Src1 << Shamt;
			default: 	{Carry, Result} <= 0;
		endcase
		
	end
	
	always @ (Result)
	begin
		if (Result == 32'b0)Zero = 1'b1;
		else Zero = 1'b0;
	end
	
endmodule