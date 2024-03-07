
module decypher(
    input [2:0] N,
    output [7:0] result
);

    assign result[0] = ~N[0] & ~N[1] & ~N[2];
    assign result[1] = N[0] & ~N[1] & ~N[2];
    assign result[2] = ~N[0] & N[1] & ~N[2];
    assign result[3] = N[0] & N[1] & ~N[2];
    assign result[4] = ~N[0] & ~N[1] & N[2];
    assign result[5] = N[0] & ~N[1] & N[2];
    assign result[6] = ~N[0] & N[1] & N[2];
    assign result[7] = N[0] & N[1] & N[2];
    
endmodule