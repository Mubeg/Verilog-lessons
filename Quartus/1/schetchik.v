// `include "hex2seven_seg.v"

module schetchik(
    input clk,
    input reset,
    input w_button2,
    input w_button3,
    output [6:0] seven_segmnet
);


reg [3:0] counter;

reg __button2, __button3;
reg _button2, _button3;
wire button2, button3;

assign button2 = ~_button2 & __button2;
assign button3 = ~_button3 & __button3;


hex2seven_seg inst1(
    .hex(counter),
    .seven_segmnet(seven_segmnet)
);

always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

    __button3 <= ~reset ? 0 : ~w_button3;
    _button3 <= ~reset ? 0 : __button3;

    counter <=  ~reset ? 0 :
                button2 ? counter + 1'h1 :
                button3 ? counter - 1'h1 : counter;
    

end


endmodule