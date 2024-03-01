
//  Существует признак делимости на 3 в двоичной системе: сумма всех чисел на нечетных позициях
//  и сумма на четных должны по отдельности (или их разница) делиться на 3 без остатка.
//  Однако с точки зрения работы аппаратуры (по моему мнению) вычисление сумм требует больше транзисторов  

module divide_by_3(
    input [31:0] number,
    input start_c,
    input last_div,
    output last_div_update,
    output start_c_update,
    output result,
    output [31:0] div
);
    wire [32:0] divided;
    wire [32:0] remember;
    assign remember[0] = start_c;
    assign divided[0] = last_div;
    
    genvar i;       // Вопрос: Правильно ли я понял, что genvar + generate работают на этапе компиляции 
                    // и позволяют упростить написание больших assign конструкций?
    generate 
        for (i = 0; i < 32; i = i + 1) begin
            assign divided[i+1] = number[i] ^ remember[i];
            assign remember[i+1] = (~number[i] & divided[i] & ~remember[i]) | (number[i] & ~divided[i] & ~remember[i]);
        end
    endgenerate

    assign result = ~(divided[32] | remember[32]);
    assign start_c_update = remember[32];
    assign last_div_update = divided[32];
    assign div = divided[32:1];
endmodule

// Logic Table
//
// Number   [i]     0   0   0   0   1   1   1   1
// Divided  [i-1]   0   0   1   1   0   0   1   1
// Remember [i]     0   1   0   1   0   1   0   1
// Effectively      0   1   2   1   0   1   2   1
// 
// Divided  [i]     0   1   0   1   1   0   1   0
// Remember [i+1]   0   0   1   0   1   0   0   0

// Effectively      0   2   1   2   1   0   2   0
