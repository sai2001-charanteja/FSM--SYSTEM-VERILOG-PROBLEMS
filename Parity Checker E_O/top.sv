module top;

bit clk;
logic reset;
logic data_in;
logic valid;
logic mode;
logic parity_ok;

always #5 clk = !clk;

testbench tb(clk,reset,data_in,valid,mode,parity_ok);
parity dut(clk,reset,data_in,valid,mode,parity_ok);


endmodule