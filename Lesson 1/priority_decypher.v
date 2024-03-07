
module priority_decypher(
    input [7:0] N,
    output [2:0] result
);  

    wire Z[7:0];

    assign Z[7] = N[7];
    assign Z[6] = N[6] & ~N[7];
    assign Z[5] = N[5] & ~N[6] & ~N[7];
    assign Z[4] = N[4] & ~N[5] & ~N[6] & ~N[7];
    assign Z[3] = N[3] & ~N[4] & ~N[5] & ~N[6] & ~N[7];
    assign Z[2] = N[2] & ~N[3] & ~N[4] & ~N[5] & ~N[6] & ~N[7];
    assign Z[1] = N[1] & ~N[2] & ~N[3] & ~N[4] & ~N[5] & ~N[6] & ~N[7];
    assign Z[0] = N[0] & ~N[1] & ~N[2] & ~N[3] & ~N[4] & ~N[5] & ~N[6] & ~N[7];

    assign result[0] = Z[7] | Z[5] | Z[3] | Z[1];
    assign result[1] = Z[7] | Z[6] | Z[3] | Z[2];
    assign result[2] = Z[7] | Z[6] | Z[5] | Z[4];
    

endmodule