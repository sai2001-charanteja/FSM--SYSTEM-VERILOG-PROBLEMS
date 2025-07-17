module top;

bit clk;
logic reset;
logic start_tx;
logic [7:0] data_in;

logic sclk;
logic mosi;
logic ss;
logic tx_done;

always #5 clk = !clk;

testbench tb(clk,reset,start_tx,data_in,sclk,mosi,ss,tx_done);
spiprotocol dut(clk,reset,start_tx,data_in,sclk,mosi,ss,tx_done);


endmodule