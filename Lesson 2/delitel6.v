
module delitel6(
    input clk,
    input reset,
    output reg clk_div6
);

reg [1:0] count;

always @(posedge clk ) begin
    if (reset)
        {clk_div6, count} <= 3'h0;
    else begin
        clk_div6  <= (count == 2'h0) ? ~clk_div6 : clk_div6;
        count     <= (count == 2'h2) ? 2'h0 : count + 1;
    end
end

endmodule
