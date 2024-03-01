
module priority_decypher(
    input [7:0] N,
    output [2:0] result
);  

    wire [2:0] a[7:0], b [3:0], c[1:0];

    assign a[0] = (N[0] == 1)? 0 : 0; // 1
    assign a[1] = (N[1] == 1)? 1 : 0; // 2
    assign a[2] = (N[2] == 1)? 2 : 0; // 3
    assign a[3] = (N[3] == 1)? 3 : 0; // 4
    assign a[4] = (N[4] == 1)? 4 : 0; // 5
    assign a[5] = (N[5] == 1)? 5 : 0; // 6
    assign a[6] = (N[6] == 1)? 6 : 0; // 7
    assign a[7] = (N[7] == 1)? 7 : 0; // 8
    assign b[0] = a[1] == 0 ? a[0] : a[1]; // 1
    assign b[1] = a[3] == 0 ? a[2] : a[3]; // 2
    assign b[2] = a[5] == 0 ? a[4] : a[5]; // 3
    assign b[3] = a[7] == 0 ? a[6] : a[7]; // 4
    assign c[0] = b[1] == 0 ? b[0] : b[1];
    assign c[1] = b[3] == 0 ? b[2] : b[3];

    assign result = c[1] == 0 ? c[0] : c[1];
    

endmodule