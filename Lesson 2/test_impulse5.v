`timescale 1ns/1ns
`include "impulse5.v"
module top();


reg reset = 0;
reg clk = 0;
always #1 clk = ~clk;

initial begin
    @(posedge clk)
    reset <= 1;
    repeat(3) @(negedge clk);
    reset <= 0;
end

wire impulse5;

impulse5         // returns in "result" 0 if is not dividable, 1 otherwise
test(
    .clk    (clk),
    .reset  (reset),
    .impulse5(impulse5)
);


endmodule

