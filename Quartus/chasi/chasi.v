
module chasi(
    input clk,
    input reset,
    input w_button2, w_button3, w_button4,
    output [6:0] ss1, ss3, ss4, ss5, ss6, ss7, ss8
);

reg [31:0] clock_counter;

reg [7:0] counter;
reg [7:0] blink_counter;

reg [7:0] mem[2:0];     // mem for output

reg [3:0] change_counter;

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

wire [11:0] td1, td2, td3;

// DECIMAL CONVERISON

hex2decimal inst9(
    .hex(mem[0][7:0]),
    .decimal(td1)
);

hex2decimal inst10(
    .hex(mem[1][7:0]),
    .decimal(td2)
);

hex2decimal inst11(
    .hex(mem[2][7:0]),
    .decimal(td3)
);

// SEVEN SEGMENT OUTPUT

hex2seven_seg inst1(
    .hex(change_counter),
    .CE(1'b1),
    .seven_segment(ss1)
);

hex2seven_seg inst3(
    .hex(td1[3:0]),
    .CE(blink[0]),
    .seven_segment(ss3)
);

hex2seven_seg inst4(
    .hex(td1[7:4]),
    .CE(blink[0]),
    .seven_segment(ss4)
);

hex2seven_seg inst5(
    .hex(td2[3:0]),
    .CE(blink[1]),
    .seven_segment(ss5)
);

hex2seven_seg inst6(
    .hex(td2[7:4]),
    .CE(blink[1]),
    .seven_segment(ss6)
);

hex2seven_seg inst7(
    .hex(td3[3:0]),
    .CE(blink[2]),
    .seven_segment(ss7)
);

hex2seven_seg inst8(
    .hex(td3[7:4]),
    .CE(blink[2]),
    .seven_segment(ss8)
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

    clock_counter <= ~reset ? 0 : clock_counter >= 499999 ? 0 : clock_counter + 1;
    
    counter <= ~reset | (~active) ? 0 : active ? clock_counter == 1 ? counter >= 99 ? 0 : counter + 1 : counter : counter;
    blink_counter <= ~reset ? 0 : clock_counter == 1 ? blink_counter >= 49 ? 0 : blink_counter + 1 : blink_counter;


end

always @(posedge clk) begin

    blink_buffer <= ~reset | button4 ? 8'd100 : (clock_counter == 1) & blink_buffer > 0 ? blink_buffer - 1'b1 : blink_buffer;

end

always @(posedge clk) begin

    blink[0] <= ~reset | button4 | active | change_counter != 0 ? 1 : (change_counter == 0) & (blink_counter == 1) & (clock_counter == 1) & (blink_buffer == 0) ? ~blink[0] : blink[0];
    blink[1] <= ~reset | button4 | active | change_counter != 1 ? 1 : (change_counter == 1) & (blink_counter == 1) & (clock_counter == 1) & (blink_buffer == 0) ? ~blink[1] : blink[1];
    blink[2] <= ~reset | button4 | active | change_counter != 2 ? 1 : (change_counter == 2) & (blink_counter == 1) & (clock_counter == 1) & (blink_buffer == 0) ? ~blink[2] : blink[2];

end

always @(posedge clk) begin

    active <= ~reset ? 1 : button2 ? ~active : active;

end

always @(posedge clk) begin

    change_counter <= ~reset ? 0 : button3 ? change_counter >= 2 ? 0 : change_counter + 1 : change_counter;

end


always @(posedge clk) begin

    mem[0] <= ~reset ? 0 : active ?  
                            (counter == 99) & (clock_counter == 1) ? ( mem[0] == 59 ? 0 : mem[0]+1 ) : mem[0] :
                            (change_counter == 0) & button4 ? mem[0] == 59 ? 0 : mem[0]+1 : mem[0];

    mem[1] <= ~reset ? 0 : active ?  
                            (mem[0] == 59)  & (counter == 99) & (clock_counter == 1) ? mem[1] == 59 ? 0 : mem[1]+1 : mem[1] :
                            (change_counter == 1) & button4 ? mem[1] == 59 ? 0 : mem[1]+1 : mem[1];
    
    mem[2] <= ~reset ? 0 : active ?  
                            (mem[1] == 59)  & (mem[0] == 59)  & (counter == 99) & (clock_counter == 1) ? mem[2] == 23 ? 0 : mem[2]+1 : mem[2] :
                            (change_counter == 2) & button4 ? mem[2] == 23 ? 0 : mem[2]+1 : mem[2];

end


endmodule