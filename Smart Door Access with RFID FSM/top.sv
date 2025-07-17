module top;

bit clk;
logic reset;
logic [7:0] rfid_data;
logic valid;

logic door_unlock;
logic access_granted;
logic access_denied;

always #5 clk = !clk;

testbench tb(clk,reset,rfid_data,valid,door_unlock,access_granted,access_denied);
smartlock dut(clk,reset,rfid_data,valid,door_unlock,access_granted,access_denied);


endmodule