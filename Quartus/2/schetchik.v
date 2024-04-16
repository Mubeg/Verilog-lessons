
module schetchik(
    input clk,
    input reset,
    input w_button2,
    input w_button3,
    output [7:0] diod
);


reg [2:0] counter;

reg __button2, __button3;
reg _button2, _button3;
wire button2, button3;

assign button2 = ~_button2 & __button2;
assign button3 = ~_button3 & __button3;

genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : for1
        assign diod[i] = (i < counter);
    end
endgenerate


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

    __button3 <= ~reset ? 0 : ~w_button3;
    _button3 <= ~reset ? 0 : __button3;

end

always @(posedge clk) begin
    counter <=  ~reset ? 0 :
                button2 ? counter + 1'h1 :
                button3 ? counter - 1'h1 : counter;
    

end


endmodule