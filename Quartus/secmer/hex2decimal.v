module hex2decimal(
    input [7:0] hex,
    output [11:0] decimal
);

wire m_200, m_100;
wire [7:0] temp_hex;
wire [3:0] temp_hex1;

assign m_200 = hex >= 200;
assign m_100 = hex >= 100;

assign decimal[11:10] = 2'b0;
assign decimal[9] = m_200;
assign decimal[8] = m_100 & ~m_200;

assign temp_hex = hex - (m_200 ? 200 : 0) - ((m_100 & ~m_200) ? 100 : 0);


assign decimal[7:4] =   {7{temp_hex >= 10 & temp_hex < 20}} & 4'd1 |
                        {7{temp_hex >= 20 & temp_hex < 30}} & 4'd2 |
                        {7{temp_hex >= 30 & temp_hex < 40}} & 4'd3 |
                        {7{temp_hex >= 40 & temp_hex < 50}} & 4'd4 |
                        {7{temp_hex >= 50 & temp_hex < 60}} & 4'd5 |
                        {7{temp_hex >= 60 & temp_hex < 70}} & 4'd6 |
                        {7{temp_hex >= 70 & temp_hex < 80}} & 4'd7 |
                        {7{temp_hex >= 80 & temp_hex < 90}} & 4'd8 |
                        {7{temp_hex >= 90}}                 & 4'd9;

assign temp_hex1 = temp_hex - decimal[7:4]*10;

assign decimal[3:0] = temp_hex1;

endmodule