`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2023 10:37:28 PM
// Design Name: 
// Module Name: rand_tb
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


module rand_tb();

reg clk;
reg load;
reg areset;
wire [15:0] rnd;

Random random_inst (
    .clk(clk),
    .load(load),
    .areset(areset),
    .rnd(rnd)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    areset = 1;
    load = 0;
    #10;
    areset = 0;
    #10;
    areset = 1;
    load = 1;
    #10;
    areset = 0;
    #10;
    areset = 1;
    load = 0;
    #10;
    areset = 0;
    #10;
    $stop;
end

endmodule