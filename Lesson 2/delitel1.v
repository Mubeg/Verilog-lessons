
module delitel1(
    input clk,
    input reset,
    output reg clk_div2,
    output reg clk_div4,
    output reg clk_div8
);

always @(posedge clk ) begin
    if (reset)
        {clk_div2, clk_div4, clk_div8} <= 3'h0;
    else begin
        clk_div2 <= ~clk_div2;
        clk_div4 <= (clk_div2 & clk) ? ~clk_div4 : clk_div4;
        clk_div8 <= (clk_div4 & clk_div2 & clk) ? ~clk_div8 : clk_div8;
    end
end

endmodule