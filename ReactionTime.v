module ReactionTime (
	input user_btn, 
	input areset,
	input clk,
	output reg led,
	output reg[6:0] testL,
	output reg[2:0] state, 
	output reg[13:0] reaction
);

parameter   pre_countdown = 3'b000,
			init = 3'b001,
			countdown = 3'b010,
			test = 3'b011,
			early = 3'b100,
			good = 3'b101,
			late = 3'b110;

wire slowclk;
reg enableCD;
reg enableCU;
wire [13:0] limit;
wire [13:0] random;
wire [13:0] counterUp;
wire [13:0] counterDown;
wire CDTick;
wire CUTick;
reg BtnMode;

assign limit = random;

SlowClock clockdivider(
	.clk(clk),.areset(areset),.clk_1Hz(slowclk)
);

Random randomgen(
	.clk(clk),
	.load(user_btn),
	.areset(areset),
	.rnd(random)
);

Counting countingdown (
	.clk(slowclk),
	.areset(areset),
	.enable(enableCD),
	.done(CDTick),
	.limit(limit),
	.outputNum(counterDown)
);

Counting countingup (
	.clk(slowclk),
	.areset(areset),
	.enable(enableCU),
	.done(CUTick),
	.limit(10000),
	.outputNum(counterUp)
);

always @(posedge clk or posedge areset) begin
	case(state)
		pre_countdown: begin
			if (~user_btn & BtnMode) begin
				state <= countdown;
				enableCD <= 1;
				enableCU <= 0;
				BtnMode <= 1;
			end
		end
		init: begin
			if(areset) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
			else if(user_btn & ~BtnMode) begin
				state <= pre_countdown;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 1;
			end
		end	
		countdown: begin
			if(areset) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
			else if(CDTick) begin
				state <= test;
				led <= 1;
				enableCD <= 0;
				enableCU <= 1;
			end
			else if(user_btn & BtnMode) begin
				state <= early;
				reaction <= 9999;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
		end
		test: begin
			reaction <= counterUp;
			if(areset) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
			else if(CUTick) begin
				state <= late;
				led <= 0;
				reaction <= 10000;
				enableCD <= 0;
				enableCU <= 0;
			end
			else if(user_btn && BtnMode) begin
				state <= good;
				led <= 0;
				reaction <= counterUp;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
		end
		default: begin
			if(areset) begin
				state <= init;
				led <= 0;
				reaction <= 0;
				enableCD <= 0;
				enableCU <= 0;
				BtnMode <= 0;
			end
		end
	endcase
end

endmodule
