module top;
	
bit clk;
logic reset;
logic [1:0] coin;
logic product_dispence;
logic [2:0]return_change;

always #5 clk = !clk;

testbench tb(clk,reset,coin,product_dispence,return_change);
vending dut(clk,reset,coin,product_dispence,return_change);


endmodule