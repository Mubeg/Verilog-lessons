`timescale 1ns/1ns
`include "divide_by_3.v"
module top();

reg [63:0] big_num_test;
wire [63:0] big_num_res;

reg [31:0] num_test;
wire [31:0] num_res;
wire result;
wire last_div_update, start_c_update;
reg start_c;
reg last_div;

always
begin
    #1
    big_num_test[31:0] = $random();
    big_num_test[63:32] =  $random();
    num_test = $random();
    start_c = 0;        // if need to divide a number with more than 32 bits assign the "result" of function divide_by_3 to this and 
    last_div = 0;       // last_div_update to this and repeat module
end


divide_by_3         // returns in "result" 0 if is not dividable, 1 otherwise
test(
    .number (num_test),
    .start_c   (start_c),
    .last_div   (last_div),
    .last_div_update(last_div_update),
    .start_c_update(start_c_update),
    .result (result),
    .div (num_res)
);

wire big_c_update1, big_div_update1, big_result_1;

divide_by_3         // returns in "result" 0 if is not dividable, 1 otherwise
test_big1(
    .number (big_num_test[31:0]),
    .start_c   (start_c),
    .last_div   (last_div),
    .last_div_update(big_div_update1),
    .start_c_update(big_c_update1),
    .result (big_result_1),
    .div (big_num_res[31:0])
);

wire big_c_update2, big_div_update2, big_result_2;

divide_by_3         // returns in "result" 0 if is not dividable, 1 otherwise
test_big2(
    .number (big_num_test[63:32]),
    .start_c   (big_c_update1),
    .last_div   (big_div_update1),
    .last_div_update(big_div_update2),
    .start_c_update(big_c_update2),
    .result (big_result_2),
    .div (big_num_res[63:32])
);

wire    check;
wire    is_dividable;
assign  is_dividable = (num_test % 3) == 0;
assign  check = (result == is_dividable);

wire    check_division;
assign  check_division = (is_dividable) ? (num_test / 3 == num_res) : 1;  

wire    check_big;
wire    is_dividable_big;
assign  is_dividable_big = (big_num_test % 3) == 0;
assign  check_big = (big_result_2 == is_dividable_big);

wire    check_division_big;
assign  check_division_big = (is_dividable_big) ? (big_num_test / 3 == big_num_res) : 1;  

endmodule

