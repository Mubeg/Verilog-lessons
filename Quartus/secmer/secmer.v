
module secmer(
    input clk,
    input reset,
    input w_button2, w_button3, w_button4,
    output [6:0] ss1, ss2, ss3, ss4, ss5, ss6, ss7
);

reg [31:0] clock_counter, clock_counter2;

reg[7:0] counter, counter2;

reg [15:0] mem[4:0];    // mem for show and update
reg [15:0] mem_cur;     // mem for output
reg [7:0] mem_temp;    // mem for write

reg [3:0] show_counter, write_counter;

reg active;

reg __button2, __button3, __button4;
reg _button2, _button3, _button4;
wire button2, button2_up, button3, button3_up, button4, button4_up;

assign button2 = ~_button2 & __button2;
assign button2_up = _button2 & ~__button2;

assign button3 = ~_button3 & __button3;
assign button3_up = _button3 & ~__button3;

assign button4 = ~_button4 & __button4;
assign button4_up = _button4 & ~__button4;

wire [11:0] td1, td2, td3;

// DECIMAL CONVERISON

hex2decimal inst9(
    .hex(mem_cur[15:8]),
    .decimal(td1)
);

hex2decimal inst10(
    .hex(mem_temp),
    .decimal(td2)
);

hex2decimal inst11(
    .hex(mem_cur[7:0]),
    .decimal(td3)
);

// SEVEN SEGMENT OUTPUT


hex2seven_seg inst1(
    .hex(td3[3:0]),
    .seven_segment(ss1)
);

hex2seven_seg inst2(
    .hex(td3[7:4]),
    .seven_segment(ss2)
);

hex2seven_seg inst3(
    .hex(td1[3:0]),
    .seven_segment(ss3)
);

hex2seven_seg inst4(
    .hex(td1[7:4]),
    .seven_segment(ss4)
);

hex2seven_seg inst5(
    .hex(td2[3:0]),
    .seven_segment(ss5)
);

hex2seven_seg inst6(
    .hex(td2[7:4]),
    .seven_segment(ss6)
);

hex2seven_seg inst7(
    .hex(show_counter),
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

    clock_counter <= ~reset ? 0 : clock_counter >= 500000 ? 0 : clock_counter + 1;
    clock_counter2 <= ~reset ? 0 : clock_counter >= 50000 ? 0 : clock_counter + 1;
    
    counter <= ~reset | (~active & button3) ? 0 : active ? clock_counter == 1 ? counter >= 99 ? 0 : counter + 1 : counter : counter;
    counter2 <= ~reset | (~active & button3) ? 0 : active ? clock_counter2 == 1 ? counter2 >= 99 ? 0 : counter2 + 1 : counter2 : counter2;

end

always @(posedge clk) begin

    active <= ~reset ? 0 : (show_counter == 0) & button2 ? ~active : active;

end

always @(posedge clk) begin

    show_counter <= ~reset ? 0 : ~active & button4 ? show_counter >= 4 ? 0 : show_counter + 1 : show_counter;
    write_counter <= ~reset | (~active & button3) ? 1 : button3 & write_counter < 5 ? write_counter + 1 : write_counter;

end


always @(posedge clk) begin

    mem_cur <= ~reset ? 0 : mem[show_counter];
    mem_temp <= ~reset | (~active & button3) ? 0 : button3 ? mem[0][15:8] : mem_temp;

end


always @(posedge clk) begin

    mem[0] <= ~reset | (~active & button3) ? 0 : active ? counter == 99 ? mem[0][15:8] >= 99 ? 0 :
                                                    {mem[0][15:8] + 1'b1, 8'b0} :
                                                    {mem[0][15:8], counter[7:0]} :
                                                    mem[0];
    mem[1] <= ~reset | (~active & button3) ? 0 : (write_counter == 1) & button3 ? mem[0] : mem[1];
    mem[2] <= ~reset | (~active & button3) ? 0 : (write_counter == 2) & button3 ? mem[0] : mem[2];    
    mem[3] <= ~reset | (~active & button3) ? 0 : (write_counter == 3) & button3 ? mem[0] : mem[3];
    mem[4] <= ~reset | (~active & button3) ? 0 : (write_counter == 4) & button3 ? mem[0] : mem[4];

end


endmodule