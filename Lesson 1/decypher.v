
module decypher(
    input [2:0] N,
    output [7:0] result
);
    assign result = 8'b1 << N;
endmodule