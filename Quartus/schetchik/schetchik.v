
module schetchik(
    input clk,
    input reset,
    input w_button2,
    input w_button3,
    input [7:0] switch,
    output [7:0] diod1,
    output [7:0] diod2,
    output [6:0] seven_segment1, seven_segment2
);

reg [7:0] mem1;
reg [7:0] mem2;

reg __button2, __button3;
reg _button2, _button3;
wire button2, button3;

assign button2 = ~_button2 & __button2;
assign button3 = ~_button3 & __button3;

hex2seven_seg inst1(
    .hex(mem1[3:0]),
    .seven_segment(seven_segment1)
);

hex2seven_seg inst2(
    .hex(mem1[7:4]),
    .seven_segment(seven_segment2)
);


genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : for1
        assign diod1[i] = mem1[i];
        assign diod2[i] = mem2[i];
    end
endgenerate


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

    __button3 <= ~reset ? 0 : ~w_button3;
    _button3 <= ~reset ? 0 : __button3;

end

always @(posedge clk) begin

    mem1 <=  ~reset ? 0 : 
            button2 ? switch :
            button3 ? {1'b0, mem1[7:1]} : mem1;
    mem2 <=  ~reset ? 0 :
            button3 ? {mem1[0], mem2[7:1]}: mem2;
    

end


endmodule