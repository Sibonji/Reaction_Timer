`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 02:51:39 AM
// Design Name: 
// Module Name: ReactionTime_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ReactionTime_tb();
    reg user_btn;
    reg areset;
	reg clk;
	wire       led;
	wire[6:0]  testL;
	wire[2:0]  state; 
	wire[13:0] reaction;

    ReactionTime ReactionTime_inst (
	    .user_btn(user_btn),
        .areset(areset),
        .clk(clk),
        .led(led),
        .testL(testL),
        .state(state),
        .reaction(reaction)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        #15;
        areset <= 1;
        clk <= 0;
        #10;
        areset <= 0;
        #10;
        user_btn <= 1;
        #20;
        user_btn <= 0;

        i = 0;
        while (led == 0) begin
            i = i + 1;
            @(posedge clk);
        end

        #1000;
        user_btn <= 1;
        #20;

        $stop;
    end

endmodule
