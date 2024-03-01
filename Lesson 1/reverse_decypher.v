
module reverse_decypher(
    input [7:0] N,
    output [2:0] result
);  

    wire [2:0] a1, a2, a3, a4, a5, a6, a7, a8;

    assign a1 = (N[0] == 1)? 0 : 0; // 1
    assign a2 = (N[1] == 1)? 1 : 0; // 2
    assign a3 = (N[2] == 1)? 2 : 0; // 3
    assign a4 = (N[3] == 1)? 3 : 0; // 4
    assign a5 = (N[4] == 1)? 4 : 0; // 5
    assign a6 = (N[5] == 1)? 5 : 0; // 6
    assign a7 = (N[6] == 1)? 6 : 0; // 7
    assign a8 = (N[7] == 1)? 7 : 0; // 8
    assign result = a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8;
    

endmodule