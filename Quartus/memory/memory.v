`include "hex2seven_seg.v"

module memory(
    input clk,
    input reset,
    input [7:0] value,
    input [2:0] addr,
    input w_button2, w_button3, w_button4,
    output [7:0] led,
    output [6:0] ss1, ss2, ss5, ss6, ss7
);


reg [7:0] mem[7:0];
reg [7:0] mem_cur;

reg active;

reg [2:0] blink;
reg [7:0] blink_buffer;

reg __button2, __button3, __button4;
reg _button2, _button3, _button4;
wire button2, button2_up, button3, button3_up, button4, button4_up;

assign button2 = ~_button2 & __button2;
assign button2_up = _button2 & ~__button2;

assign button3 = ~_button3 & __button3;
assign button3_up = _button3 & ~__button3;

assign button4 = ~_button4 & __button4;
assign button4_up = _button4 & ~__button4;

assign led = mem_cur;


hex2seven_seg inst1(
    .hex(mem_cur[3:0]),
    .CE(1),
    .seven_segment(ss1)
);

hex2seven_seg inst2(
    .hex(mem_cur[7:4]),
    .CE(1),
    .seven_segment(ss2)
);

hex2seven_seg inst5(
    .hex(value[3:0]),
    .CE(1),
    .seven_segment(ss5)
);

hex2seven_seg inst6(
    .hex(value[7:4]),
    .CE(1),
    .seven_segment(ss6)
);

hex2seven_seg inst7(
    .hex({1'b0, addr[2:0]}),
    .CE(1),
    .seven_segment(ss7)
);


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

    __button3 <= ~reset ? 0 : ~w_button3;
    _button3 <= ~reset ? 0 : __button3;

    __button4 <= ~reset ? 0 : ~w_button4;
    _button4 <= ~reset ? 0 : __button4;

end

always @(posedge clk) begin

    mem_cur = button3 ? mem[addr] : mem_cur;

end


always @(posedge clk) begin

    mem[0] <= ~reset ? 0 : button2 & addr == 0 ? value : mem[0];
    mem[1] <= ~reset ? 0 : button2 & addr == 1 ? value : mem[1];
    mem[2] <= ~reset ? 0 : button2 & addr == 2 ? value : mem[2];
    mem[3] <= ~reset ? 0 : button2 & addr == 3 ? value : mem[3];
    mem[4] <= ~reset ? 0 : button2 & addr == 4 ? value : mem[4];
    mem[5] <= ~reset ? 0 : button2 & addr == 5 ? value : mem[5];
    mem[6] <= ~reset ? 0 : button2 & addr == 6 ? value : mem[6];
    mem[7] <= ~reset ? 0 : button2 & addr == 7 ? value : mem[7];
end

endmodule