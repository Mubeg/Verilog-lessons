
module mig(
    input clk,
    input reset,
    input w_button2,
    input [13:0] switch,
    output [6:0] ss1, ss2, ss3, ss4,
    output diod
);

reg [15:0] clock_counter;
reg [13:0] mem1;
reg [14:0] counter;

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
    .hex(mem1[11:8]),
    .seven_segment(ss3)
);

hex2seven_seg inst4(
    .hex({2'b0, mem1[13:12]}),
    .seven_segment(ss4)
);


assign diod = mem1 > counter;


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

end

always @(posedge clk) begin

    clock_counter <= ~reset ? 0 : clock_counter >= 50000 ? 0 : clock_counter + 1;
    mem1 <=  ~reset ? 0 : button2 ? switch : mem1;
    counter <= ~reset ? 0 : clock_counter == 1 ? counter == mem1 + mem1 ? 0: counter + 1 : counter;

end


endmodule