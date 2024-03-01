`timescale 1ns/1ns
`include "priority_decypher.v"
module top();


reg [7:0]   num_test;
reg [2:0]   ans;
wire [2:0]  result;


initial begin
    num_test = 1;
    ans = 0;
end
always
begin
    #5
    num_test = num_test << 1;
    num_test = num_test + 1;
    ans = ans + 1;
end

priority_decypher
test_decypher(
    .N (num_test),
    .result  (result)
);

wire    check;
assign  check = (result == ans);

endmodule

