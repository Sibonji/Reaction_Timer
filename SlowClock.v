module SlowClock(
	input wire clk, 
    input wire areset, 
	output reg clk_1Hz
);

reg [27:0] counter;

always@(posedge areset or posedge clk) begin
    if (areset) begin
        clk_1Hz <= 0;
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
        if (counter == 1) begin
            counter <= 0;
            clk_1Hz <= ~clk_1Hz;
        end
    end
end
endmodule   