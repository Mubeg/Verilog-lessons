
module impulse5(
    input clk,
    input reset,
    output reg impulse5
);

reg [2:0] count;

always @(posedge clk ) begin
    if (reset)
        {impulse5, count} <= 3'h0;
    else begin
        
        impulse5    <= (count >= 3'h3) ? ~impulse5 : impulse5;
        count       <= (count == 3'h4) ? 3'h0 : count + 1;
    end
end

endmodule