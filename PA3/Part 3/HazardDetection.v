module HazardDetection(
	// Outputs
	output reg hazard, IF_ID_Write, PCWrite,
	// Inputs
	input wire ID_EX_MemRead,
	input wire [4:0]ID_EX_RtAddr, IF_ID_RsAddr, IF_ID_RtAddr
);

	always @ (*)
	begin
		if ((ID_EX_MemRead == 1) && ((ID_EX_RtAddr == IF_ID_RsAddr) || (ID_EX_RtAddr == IF_ID_RtAddr)))
		begin
			IF_ID_Write <= 1;
			hazard <= 1;
			PCWrite <= 0;
		end
		
		else 
		begin 
			IF_ID_Write <= 0;
			hazard <= 0;
			PCWrite <= 1;
		end
	end
endmodule