
module summator(
    input clk,
    input reset,
    input w_button2,
    input [7:0] switch1, switch2,
    output [6:0] ss1, ss2, ss3, ss4, ss5, ss6,
    output diod
);

reg [7:0] mem1;
reg [7:0] mem2;
reg [8:0] mem3;

reg __button2;
reg _button2;
wire button2, button2_up;

assign button2 = ~_button2 & __button2;
assign button2_up = _button2 & ~__button2;


hex2seven_seg inst1(
    .hex(mem1[3:0]),
    .seven_segment(ss1)
);

hex2seven_seg inst2(
    .hex(mem1[7:4]),
    .seven_segment(ss2)
);

hex2seven_seg inst3(
    .hex(mem2[3:0]),
    .seven_segment(ss3)
);

hex2seven_seg inst4(
    .hex(mem2[7:4]),
    .seven_segment(ss4)
);

hex2seven_seg inst5(
    .hex(mem3[3:0]),
    .seven_segment(ss5)
);

hex2seven_seg inst6(
    .hex(mem3[7:4]),
    .seven_segment(ss6)
);


assign diod = mem3[8];


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

end

always @(posedge clk) begin

    mem1 <=  ~reset ? 0 : button2 ? switch1 : mem1;
    mem2 <=  ~reset ? 0 : button2 ? switch2 : mem2;
    mem3 <=  ~reset ? 0 : button2_up ? mem1 + mem2 : mem3;
    

end


endmodule