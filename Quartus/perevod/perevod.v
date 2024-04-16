`include "hex2decimal.v"

module perevod(
    input clk,
    input reset,
    input w_button2,
    input [7:0] switch,
    output [6:0] ss1, ss2, ss3, ss4, ss5, ss6, ss7, ss8,
    output [7:0] diods,
    output diod_co
);

reg [7:0] mem1;
reg [11:0] mem2;

assign diods = mem1;

reg __button2;
reg _button2;
wire button2, button2_up;

assign button2 = ~_button2 & __button2;
assign button2_up = _button2 & ~__button2;


hex2seven_seg inst1(
    .hex(mem2[3:0]),
    .seven_segment(ss1)
);

hex2seven_seg inst2(
    .hex(mem2[7:4]),
    .seven_segment(ss2)
);

hex2seven_seg inst3(
    .hex(mem2[11:8]),
    .seven_segment(ss3)
);

hex2seven_seg inst4(
    .hex({4'b0}),
    .seven_segment(ss4)
);

hex2seven_seg inst5(
    .hex(mem1[3:0]),
    .seven_segment(ss5)
);

hex2seven_seg inst6(
    .hex(mem1[7:4]),
    .seven_segment(ss6)
);

hex2seven_seg inst7(
    .hex(mem2[3:0]),
    .seven_segment(ss7)
);

hex2seven_seg inst8(
    .hex(mem2[7:4]),
    .seven_segment(ss8)
);

assign diod_co = mem2[8] | mem2[9];


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

end

wire [11:0] temp_decimal;

hex2decimal inst9(
    .hex(mem1[7:0]),
    .decimal(temp_decimal)
);

always @(posedge clk) begin

    mem1 <=  ~reset ? 0 : button2 ? switch : mem1;
    mem2 <=  ~reset ? 0 : button2_up ? temp_decimal : mem2;

end


endmodule