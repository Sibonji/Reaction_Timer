module Counting (
	input wire clk, 
	input wire enable,
	input wire areset,
	input wire [13:0] limit,
	output reg done,
	output reg [13:0] outputNum
);


always @(posedge clk or posedge areset) begin
	if (areset) begin
		outputNum <= 0;
		done <= 0;
	end
	else if (enable) begin
		if(outputNum < limit)
			outputNum <= outputNum + 1'b1;
		else
			done <= 1;
	end
	else begin
		outputNum <= 0;
		done <= 0;
	end
end


endmodule
