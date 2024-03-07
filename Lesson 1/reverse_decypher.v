
module reverse_decypher(
    input [7:0] N,
    output [2:0] result
);  

    assign result[0] = N[7] | N[5] | N[3] | N[1];
    assign result[1] = N[7] | N[6] | N[3] | N[2];
    assign result[2] = N[7] | N[6] | N[5] | N[4];


endmodule