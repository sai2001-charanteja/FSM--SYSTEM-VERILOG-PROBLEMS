module top;

logic reset; 
logic [3:0]floor_requested; // one hot signal
logic [1:0]current_floor;
logic move_up,move_down,door_open;

 bit clk;
 always #5 clk = !clk;
 
 testbench tb(clk,reset,floor_requested,current_floor,move_up,move_down,door_open);
 elevator dut(clk,reset,floor_requested,current_floor,move_up,move_down,door_open);
 
 
endmodule