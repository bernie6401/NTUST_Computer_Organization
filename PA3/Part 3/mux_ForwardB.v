module mux_ForwardB(
	// Outputs
	output reg [31:0]ALU_mux_input,
	// Inputs
	input wire [31:0]RtData, RdData_forward, ALU_Result_forward,
	input wire [1:0]forwarding
);
	
	always @ (*)
	begin
		if (forwarding== 2'b00)ALU_mux_input = RtData;
		else if (forwarding== 2'b01) ALU_mux_input = RdData_forward;
		else if (forwarding== 2'b10) ALU_mux_input = ALU_Result_forward;
	end
	
endmodule

