
module divide_by_3(
    input [31:0] number,
    input start_c,
    input last_overflow,
    output last_overflow_update,
    output start_c_update,
    output result,
    output [31:0] div
);
    wire [31:0] divided;
    wire [32:0] remember;
    wire [32:0] overflowed;

    //Overflowed cannot be 1 if remember is 0, so change them

    assign remember[0] = last_overflow & ~start_c ? last_overflow : start_c;
    assign overflowed[0] = last_overflow & ~start_c ? start_c : last_overflow;
    
    genvar i;
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            assign overflowed[i+1] = (number[i] & overflowed[i] & remember[i]) | (~number[i] & ~overflowed[i] & remember[i]);
            assign remember[i+1] = (number[i] | overflowed[i] | remember[i]) & (~number[i] | overflowed[i] | ~remember[i]);
            assign divided[i] = remember[i+1] & (number[i] | ~overflowed[i] | ~remember[i]);
        end
    endgenerate

    assign result = ~remember[32];
    assign start_c_update = remember[32];
    assign last_overflow_update = overflowed[32];
    assign div = divided;
endmodule

// Logic Table 
// X = not posible
//                              X               X
// Number       [i]     0   0   0   0   1   1   1   1
// Overflowed   [i]     0   0   1   1   0   0   1   1
// Remember     [i]     0   1   0   1   0   1   0   1

// 
// Divided      [i]     0   1   1   0   1   0   0   1
// Overflowed   [i+1]   0   1   1   0   0   0   0   1
// Remember     [i+1]   0   1   1   1   1   0   0   1
