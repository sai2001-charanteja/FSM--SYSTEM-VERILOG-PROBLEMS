module top;

logic reset;
logic [3:0]keypad_input;
logic enter;
logic unlocked;
logic [1:0] attempts_left;
logic locked_out;

 bit clk;
 always #5 clk = !clk;
 
 testbench tb(clk,reset,keypad_input,enter,unlocked,attempts_left,locked_out);
 digitallocksystem dut(clk,reset,keypad_input,enter,unlocked,attempts_left,locked_out);
 
 
endmodule