`timescale 1ns/1ns
`include "is_even.v"
module top();

reg [31:0] num_test;
wire result;

always
begin
    #1
    num_test = $random();
end

is_even
test_even(
    .number (num_test),
    .even   (result)
);

wire    check;
assign  check = (result != num_test%2);  

endmodule

