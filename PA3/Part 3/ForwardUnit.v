module ForwardUnit(
	// Outputs
	output reg [1:0]ForwardA, ForwardB,
	// Inputs
	input wire [4:0]ID_EX_RsAddr, ID_EX_RtAddr, EX_MEM_RdAddr, MEM_WB_RdAddr,
	input wire EX_MEM_RegWrite, MEM_WB_RegWrite
);

	
	always @ (*)
	begin 
		if ((EX_MEM_RegWrite == 1) && (EX_MEM_RdAddr!=0) && (EX_MEM_RdAddr == ID_EX_RsAddr)) ForwardA <= 2'b10;
		else if ((EX_MEM_RegWrite == 1) && (EX_MEM_RdAddr!=0) && (EX_MEM_RdAddr == ID_EX_RtAddr)) ForwardB <= 2'b10;
		
		else if ((MEM_WB_RegWrite == 1) && (MEM_WB_RdAddr!=0) && (MEM_WB_RdAddr == ID_EX_RsAddr) && (EX_MEM_RdAddr != ID_EX_RsAddr)) ForwardA <= 2'b01;
		else if ((MEM_WB_RegWrite == 1) && (MEM_WB_RdAddr!=0) && (MEM_WB_RdAddr == ID_EX_RtAddr) && (EX_MEM_RdAddr != ID_EX_RtAddr)) ForwardB <= 2'b01;
		
		else 
		begin
			ForwardA <= 0;
			ForwardB <= 0;
		end
	end
	
endmodule
