//////////////////////////////////////////////////////////////////////////////////
//
// Revision: module approved v1.0
//
//////////////////////////////////////////////////////////////////////////////////

module flipFlop(
	input wire clk,
	input wire areset,
	input wire d,
	output reg q
);

reg r_reg;
reg r_next;

always @(posedge clk or negedge areset) begin
	if (areset)
		q <= 1'b0;
	else
		q <= d;
end

endmodule
