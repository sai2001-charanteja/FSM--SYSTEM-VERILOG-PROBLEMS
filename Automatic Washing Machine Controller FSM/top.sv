module top;

bit clk;
logic reset;
logic start;
logic pause;
logic [2:0] stage;
logic done;

always #5 clk = !clk;

testbench tb(clk,reset,start,pause,stage,done);
washingMachine dut(clk,reset,start,pause,stage,done);


endmodule