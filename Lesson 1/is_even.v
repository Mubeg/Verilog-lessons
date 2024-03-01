
module is_even(
    input [31:0] number,
    output even
);
    assign even = ~number[0];
endmodule