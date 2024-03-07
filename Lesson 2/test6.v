`timescale 1ns/1ns
`include "delitel6.v"
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

wire clk_div6;

delitel6         // returns in "result" 0 if is not dividable, 1 otherwise
test(
    .clk    (clk),
    .reset  (reset),
    .clk_div6(clk_div6)
);


endmodule

