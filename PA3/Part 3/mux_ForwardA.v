module mux_ForwardA(
	// Outputs
	output reg [31:0]ALU_input,
	// Inputs
	input wire [31:0]RsData, RdData_forward, ALU_Result_forward,
	input wire [1:0]forwarding
);
	
	always @ (*)
	begin
		if (forwarding== 2'b00)ALU_input = RsData;
		else if (forwarding== 2'b01) ALU_input = RdData_forward;
		else if (forwarding== 2'b10) ALU_input = ALU_Result_forward;
	end
	
endmodule
