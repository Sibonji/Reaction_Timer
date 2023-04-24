//////////////////////////////////////////////////////////////////////////////////
//
// Revision: module approved v1.0
//
//////////////////////////////////////////////////////////////////////////////////

module Mux(
	input wire din_0,
	input wire din_1,
	input wire sel, 
	output reg mux_out
);

//probably need to change always block to continuous statement (tristate)

always @*
	if (sel == 1'b0)
		mux_out = din_0;
	else 
		mux_out = din_1;
		
endmodule
