//`include "decypher.v"

module sdvig(
    input clk,
    input reset,
    input w_button2,
    input w_button3,
    input switch0,
    input switch1,
    output [7:0] diod
);


reg [7:0] memory;

genvar i;
generate
    for(i = 0; i < 8; i = i + 1) begin : for1
        assign diod[i] = memory[i];
    end
endgenerate

reg __button2, __button3;
reg _button2, _button3;
wire button2, button3;

assign button2 = ~_button2 & __button2;
assign button3 = ~_button3 & __button3;


always @(posedge clk) begin

    __button2 <= ~reset ? 0 : ~w_button2;
    _button2 <= ~reset ? 0 : __button2;

    __button3 <= ~reset ? 0 : ~w_button3;
    _button3 <= ~reset ? 0 : __button3;
end

always @(posedge clk) begin

    memory <=  ~reset ? 0 :
                button3 ? {memory[6:0], switch0} :
                button2 ? {switch1, memory[7:1]} : memory;
    

end


endmodule