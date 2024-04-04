`timescale 1ns/1ns
module task3;

reg clk, rst;

reg [7:0] a, b, c;


initial begin
    clk = 1'b0;
    rst = 1'b1;
    #2;
    @(posedge clk);
    @(posedge clk);
    #1;
    rst = 1'b0;
end

always
    #1 clk = ~clk;

always @(posedge clk)
begin
    a = rst ? 8'h0 : a + b;
    b <= rst ? 8'd1 : a - b + c - 2;
    c = b + 1;
end

endmodule

