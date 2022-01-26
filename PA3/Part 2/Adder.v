module Adder
(
	output wire [31:0]AddrOut,
	input [31:0]AddrIn
);
	
	assign AddrOut=AddrIn+4;

endmodule