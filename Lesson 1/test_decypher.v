`timescale 1ns/1ns
`include "decypher.v"
module top();

reg [2:0]   num_test;
wire [7:0]  result;

initial begin
    num_test = 0;
end
always
begin
    #5
    num_test = num_test + 1;
end

decypher
test_decypher(
    .N (num_test),
    .result  (result)
);

wire    check;
assign  check = (result == 1 << num_test);

endmodule

